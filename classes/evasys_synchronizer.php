<?php
// This file is part of the Moodle plugin block_evasys_sync
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

namespace block_evasys_sync;

use http\Exception\InvalidArgumentException;
use mysql_xdevapi\Exception;

defined('MOODLE_INTERNAL') || die();

require_once($CFG->dirroot . "/local/lsf_unification/lib_his.php");
require_once($CFG->libdir . '/adminlib.php');
require_once($CFG->dirroot . '/course/lib.php');

class evasys_synchronizer {
    private $courseid;
    protected $soapclient;
    private $blockcontext;
    private $courseinformation;

    private $evasyscourseid;

    public function __construct($courseid) {
        // For testing purposes.
        if ($courseid > 0) {
            $this->courseid = $courseid;
            $this->init_soap_client();
            $this->blockcontext = \context_course::instance($courseid); // TODO Course context or block context? Check caps.
            $this->courseinformation = $this->get_course_information();
        }
    }

    public function get_evasys_courseid() {
        if ($this->evasyscourseid !== null) {
            return $this->evasyscourseid;
        }
        $course = get_course($this->courseid);

        // Fetch veranstnr from LSF view.
        establish_secondary_DB_connection();
        $lsfentry = get_course_by_veranstid(intval($course->idnumber));
        close_secondary_DB_connection();

        if (!is_object($lsfentry)) {
            throw new \Exception('Cannot sync: Connection to LSF could not be established. Please try again later.');
        }
        $this->evasyscourseid = trim($lsfentry->veranstnr) . ' ' . trim($lsfentry->semestertxt);
        return $this->evasyscourseid;
    }

    private function init_soap_client() {
        $this->soapclient = new \SoapClient(get_config('block_evasys_sync', 'evasys_wsdl_url'), [
            'trace' => 1,
            'exceptions' => 0,
            'location' => get_config('block_evasys_sync', 'evasys_soap_url')
        ]);

        $headerbody = new \SoapVar([
            new \SoapVar(get_config('block_evasys_sync', 'evasys_username'), XSD_STRING, null, null, 'Login', null),
            new \SoapVar(get_config('block_evasys_sync', 'evasys_password'), XSD_STRING, null, null, 'Password', null),
        ], SOAP_ENC_OBJECT);
        $header = new \SOAPHEADER('soap', 'Header', $headerbody);
        $this->soapclient->__setSoapHeaders($header);
    }

    public function invite_all($dates) {
        $suveys = $this->courseinformation->m_oSurveyHolder->m_aSurveys->Surveys;
        if (!$suveys instanceof \stdClass) {
            $sent = 0;
            $total = 0;
            $reminders = 0;
            $today = date("Ymd");
            for ($i = 0; $i < count($dates); $i++) {
                $survey = $suveys[$i];
                if (intval(str_replace("-", "", $dates[$i]["start"])) <= $today) {
                    $id = $survey->m_nSurveyId;
                    $soap = $this->soapclient->sendInvitationToParticipants($id);
                    $soap = str_replace(" emails sent successful", "", $soap);
                    $sent += intval(explode("/", $soap)[0]);
                    $total += intval(explode("/", $soap)[1]);
                    $start = $today; // TASK MUST RUN AT 0:00 OR YOU RISK DOUBLE INVITES.
                } else {
                    $start = $dates[$i]["start"];
                    $reminders++;
                }
                $this->setstartandend($survey->m_nSurveyId, $start, $dates[$i]["end"]);
            }
            $soap = "success/$sent/$total/$reminders";
        } else {
            $id = $this->courseinformation->m_oSurveyHolder->m_aSurveys->Surveys->m_nSurveyId;
            if (strtotime($dates[0]["start"]) <= time()) {
                $soap = $this->soapclient->sendInvitationToParticipants($id);
                $this->setstartandend($id, $dates[0]["start"], $dates[0]["end"]);
                $soap = str_replace(" emails sent successful", "", $soap);
                $soap = explode("/", $soap);
                $soap = "success/$soap[0]/$soap[1]/1";
            } else {
                $this->setstartandend($id, $dates[0]["start"], $dates[0]["end"]);
                $soap = "success/0/0/1";
            }
        }
        return $soap;
    }

    private function get_course_information() {
        $soapresult = $this->soapclient->GetCourse($this->get_evasys_courseid(), 'PUBLIC', true, true);
        if (is_soap_fault($soapresult)) {
            // This happens e.g. if there is no corresponding course in EvaSys.
            return null;
        }
        return $soapresult;
    }

    /**
     * Builds array with all surveys and additional information to surveys
     * @return array of surveys with additional information
     */
    public function get_surveys() {
        if ($this->courseinformation === null) {
            return array();
        }
        $rawsurveys = $this->courseinformation->m_oSurveyHolder->m_aSurveys->Surveys;

        if (is_object($rawsurveys)) {
            // Course only has one associated survey.
            return [$this->enrich_survey($rawsurveys)];
        }

        $enrichedsurveys = array();

        foreach ($rawsurveys as &$survey) {
            array_push($enrichedsurveys, $this->enrich_survey($survey));
        }
        return $enrichedsurveys;
    }

    /**
     * Enriches Surveys with Information
     * @param \stdClass $rawsurvey Survey without additional information
     * @return \stdClass Survey with additional information
     */
    private function enrich_survey($rawsurvey) {
        $enrichedsurvey = new \stdClass();
        $enrichedsurvey->id = $rawsurvey->m_nSurveyId;
        $enrichedsurvey->amountOfCompletedForms = $rawsurvey->m_nFormCount;
        $enrichedsurvey->surveyStatus = $this->get_survey_status($rawsurvey->m_nOpenState);
        $enrichedsurvey->formName = $this->get_form_name($rawsurvey->m_nFrmid);
        $enrichedsurvey->formIdPub = $this->get_public_formid($rawsurvey->m_nFrmid);
        $enrichedsurvey->formId = $rawsurvey->m_nFrmid;
        $start = $rawsurvey->m_oPeriod->m_sStartDate;
        $end = $rawsurvey->m_oPeriod->m_sEndDate;
        $enrichedsurvey->startDate = $start;
        $enrichedsurvey->endDate = $end;
        return $enrichedsurvey;
    }

    private function get_survey_status($statusnumber) {
        if ($statusnumber === 1) {
            return 'open';
        } else {
            return 'closed';
        }
    }

    private function get_public_formid($formid) {
        $soapresult = $this->soapclient->GetForm($formid, 'INTERNAL', false);
        $formidpub = $soapresult->FormName;
        return $formidpub;
    }

    private function get_form_name($formid) {
        $soapresult = $this->soapclient->GetForm($formid, 'INTERNAL', false);
        $formname = $soapresult->FormTitle;
        return $formname;
    }

    public function get_amount_participants() {
        if ($this->courseinformation === null || !property_exists($this->courseinformation->m_aoParticipants, "Persons")) {
            return 0;
        }

        return count($this->courseinformation->m_aoParticipants->Persons);
    }

    /**
     * Gets all email addresses of enrolled students.
     * @return array of e-mail addresses of all enrolled students
     */
    private function get_enrolled_student_email_adresses_from_usernames() {
        $emailadresses = array();

        $enrolledusers = get_users_by_capability($this->blockcontext, 'block/evasys_sync:mayevaluate');

        foreach ($enrolledusers as $user) {
            array_push($emailadresses, $user->username . "@uni-muenster.de");
        }

        return $emailadresses;
    }

    /**
     * Updates the students who can participate in the survey.
     */
    public function sync_students() {
        if ($this->courseinformation === null) {
            throw new \Exception('Cannot sync: Course not known to EvaSys');
        }

        $emailadresses = $this->get_enrolled_student_email_adresses_from_usernames();
        $evasyscourseid = $this->get_evasys_courseid();
        $students = array();

        foreach ($emailadresses as $emailadress) {
            $soapmsidentifier = new \SoapVar($emailadress, XSD_STRING, null, null, 'm_sIdentifier', null);
            $soapmsemail = new \SoapVar($emailadress, XSD_STRING, null, null, 'm_sEmail', null);
            $student = new \SoapVar(array($soapmsidentifier, $soapmsemail), SOAP_ENC_OBJECT, null, null, 'Persons', null);
            array_push($students, $student);
        }
        $personlist = new \SoapVar($students, SOAP_ENC_OBJECT, null, null, 'PersonList', null);
        $soapresult = $this->soapclient->InsertParticipants($personlist, $evasyscourseid, 'PUBLIC', false);
        $usercountnow = $this->get_course_information()->m_nCountStud;
        if (is_array($this->courseinformation->m_oSurveyHolder->m_aSurveys->Surveys)) {
            foreach ($this->courseinformation->m_oSurveyHolder->m_aSurveys->Surveys as $survey) {
                $id = $survey->m_nSurveyId;
                $this->soapclient->GetPswdsBySurvey($id, $usercountnow, 1, true, false);
            }
        } else {
            $id = $this->courseinformation->m_oSurveyHolder->m_aSurveys->Surveys->m_nSurveyId;
            $this->soapclient->GetPswdsBySurvey($id, $usercountnow, 1, true, false); // Create $newuser new TAN's.
        }
        if (is_soap_fault($soapresult)) {
            throw new \Exception('Sending list of participants to evasys server failed.');
        }
        return $soapresult;
    }

    public function setstartandendcourse ($dates) {
        $surveys = $this->courseinformation->m_oSurveyHolder->m_aSurveys;
        if (count($dates) != count($surveys)) {
            die("not the correct amount of dates supplied");
        }
        for ($i = 0; $i < count($dates); $i++) {
            $id = $this->m_oSurveyHolder->m_aSurveys->Surveys[$i];
            $this->setstartandend($id, $dates[$i]["start"], $dates[$i]["end"]);
        }
    }

    public function setstartandend ($id, $start, $end) {
        global $DB;
        if (strtotime($start) > strtotime($end) && $start != null && $end != null) {
            throw new \InvalidArgumentException("Start date is after end date");
        }

        $data = new \stdClass();
        $data->course = $this->courseid;
        $data->survey = $id;
        $data->startdate = strtotime($start);
        $data->enddate = strtotime($end);
        $recordid = $DB->get_record("block_evasys_sync_surveys", array('survey' => $id), 'id', IGNORE_MISSING);
        if (!$recordid) {
            $record = new \block_evasys_sync\evaluationperiod_survey_allocation(0, $data);
            $record->create();
        } else {
            $record = \block_evasys_sync\evaluationperiod_survey_allocation::get_record((array) $recordid);
            foreach ($data as $key => $value) {
                $record->set($key, $value);
            }
            $record->update();
        }
    }

    /**
     * Sends an e-mail with the request to start a Evaluation for a course.
     * @throws \Exception when e-mail request fails
     */
    public function notify_evaluation_responsible_person($dates) {
        global $USER;
        $course = get_course($this->courseid);

        $userto = $this->get_assigned_user($course);

        if (!$userto) {
            throw new \Exception('Could not find the specified user to send an email to.');
        }
        $userfrom =& $USER;

        $notifsubject = "Evaluation für '" . $course->fullname . "' geöffnet";

        $notiftext = "Sehr geehrte/r Evaluationskoordinator/in,\r\n\r\n";
        $notiftext .= "Dies ist eine automatisch generierte Mail, ausgelöst dadurch, dass ein Dozent die Evaluation " .
            "der nachfolgenden Veranstaltung aktiviert hat. \r\n".
            "Bitte passen Sie die Evaluationszeiträume gemäß der Wünsche des Dozenten an. \r\n".
            "Bitte versenden Sie schnellstmöglich die TANs im EvaSys-Menü " .
            "unter dem Menüpunkt 'TANs per E-Mail an Befragte versenden' für die Veranstaltung.\r\n\r\n";
        $notiftext .= "Name: " . $course->fullname . "\r\n";
        $notiftext .= "EvaSys-ID: " . $this->get_evasys_courseid() . "\r\n\r\n";
        $notiftext .= "Die Veranstaltung hat folgende Fragebögen:\r\n\r\n";

        $surveys = $this->get_surveys();
        $i = 0;
        foreach ($surveys as &$survey) {
            $notiftext .= "\tFragebogen-ID: " . $survey->formIdPub . " (" . $survey->formId . ")\r\n";
            $notiftext .= "\tFragebogenname: " . $survey->formName . "\r\n";
            $notiftext .= "\tGewünschter Evaluationszeitraum: " . $dates[$i]["start"] . " - " . $dates[$i]["end"] . "\r\n\r\n";
            $i++;
        }

        $notiftext .= "Mit freundlichen Grüßen\r\n";
        $notiftext .= "Learnweb-Support";

        $mailresult = email_to_user($userto, $userfrom, $notifsubject, $notiftext, '', '' , '',
            true, $userfrom->email, $userfrom->firstname . " " . $userfrom->lastname);
        if (!$mailresult) {
            throw new \Exception('Could not send e-mail to person responsible for evaluation');
        }
    }

    /**
     * Returns the user to whom the email is sent.
     * @param $course
     * @return bool|\stdClass user
     */
    static public function get_assigned_user($course) {
        global $DB;

        $user = $DB->get_record('block_evasys_sync_categories', array('course_category' => $course->category));
        // Custom user has not been set.
        if (!$user) {
            // Loop through parents.
            $parents = \core_course_category::get($course->category)->get_parents();
            // Start with direct parent.
            for ($i = count($parents) - 1; $i >= 0; $i--) {
                $user = $DB->get_record('block_evasys_sync_categories', array('course_category' => $parents[$i]));
                // Stop if a parent has been assigned a custom user.
                if ($user) {
                    $userto = \core_user::get_user($user->userid);
                    break;
                }
            }
            // Custom user has not been set for parents.
            if (!$user) {
                // User default user.
                $userto = \core_user::get_user(get_config('block_evasys_sync', 'default_evasys_moodleuser'));
            }
        } else {
            // Use custom user of the course category of the course.
            $userto = \core_user::get_user($user->userid);
        }
        return $userto;
    }
}
