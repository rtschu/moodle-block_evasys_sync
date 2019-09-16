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

use block_evasys_sync\course_evaluation_allocation;

defined('MOODLE_INTERNAL') || die();

class block_evasys_sync extends block_base{

    /**
     * Initializes the block.
     */
    public function init() {
        $this->title = get_string('evasys_sync', 'block_evasys_sync');
    }

    /**
     * Returns the content object
     *
     * @return object
     */
    public function get_content() {
        global $OUTPUT;
        $evasyssynccheck = optional_param('evasyssynccheck', 0, PARAM_BOOL);
        $status = optional_param('status', "", PARAM_TEXT);

        if ($this->content !== null) {
            return $this->content;
        }

        $this->content = new stdClass();
        $this->content->text = '';

        $access = has_capability('block/evasys_sync:synchronize', context_course::instance($this->page->course->id));
        $inlsf = !empty($this->page->course->idnumber);
        if (!$access) {
            return $this->content;
        }

        if ($status === 'success') {
            $this->page->requires->js_call_amd('block_evasys_sync/post_dialog', 'show_dialog_success');
        } else if ($status === 'uptodate') {
            $this->page->requires->js_call_amd('block_evasys_sync/post_dialog', 'show_dialog_up_to_date');
        } else if ($status === 'nostudents') {
            $this->page->requires->js_call_amd('block_evasys_sync/post_dialog', 'show_dialog_no_students');
        } else if ($status === 'failure') {
            $this->page->requires->js_call_amd('block_evasys_sync/post_dialog', 'show_dialog_failure');
        }

        if ($evasyssynccheck === 1) {
            $ismodeautomated = (bool) \block_evasys_sync\evasys_inviter::getmode($this->page->course->category);
            // If the teacher can start the evaluation directly, we'll want to run some javascript initialization.
            if ($ismodeautomated) {
                $this->page->requires->js_call_amd('block_evasys_sync/invite_manager', 'init');
            }
            $evasyssynchronizer = new \block_evasys_sync\evasys_synchronizer($this->page->course->id);
            try {
                $evasyscourses = $evasyssynchronizer->get_courses_from_lsf();
            } catch (Exception $exception) {
                \core\notification::warning(get_string('syncnotpossible', 'block_evasys_sync'));
                $this->content->text .= html_writer::div(get_string('syncnotpossible', 'block_evasys_sync'));
                return $this->content;
            }

            if ($ismodeautomated) {
                $href = new moodle_url('/course/view.php',
                    array('id' => $this->page->course->id, "evasyssynccheck" => true));
            } else {
                $href = new moodle_url('/blocks/evasys_sync/sync.php');
            }

            // Get Status.
            $startdisabled = "";
            $enddisabled = "";
            $start = time();
            $oneweeklater = $time = new \DateTime();
            $oneweeklater->add(new \DateInterval("P7D"));
            $end = $oneweeklater->getTimestamp();
            $record = course_evaluation_allocation::get_record_by_course($this->page->course->id, false);
            if ($record !== false) {
                $state = $record->get('state');
                if ($state >= course_evaluation_allocation::STATE_AUTO_OPENED) {
                    $startdisabled = "disabled";
                }
                if ($state == course_evaluation_allocation::STATE_AUTO_CLOSED) {
                    $enddisabled = "disabled";
                }
                $start = $record->get('startdate');
                $end = $record->get('enddate');
            }
            $this->page->requires->js_call_amd('block_evasys_sync/initialize', 'init', array($start, $end));
            $nostudents = (count_enrolled_users(context_course::instance($this->page->course->id), 'block/evasys_sync:mayevaluate') == 0);
            // Begin form.
            $data = array(
                'href' => $href,
                'sesskey' => sesskey(),
                'courseid' => $this->page->course->id,
                'direct' => $ismodeautomated,
                'startdisabled' => $startdisabled,
                'enddisabled' => $enddisabled,
                'startoption' => $enddisabled xor $startdisabled,
                'coursemappingenabled' => !$startdisabled or is_siteadmin(),
                'nostudents' => $nostudents
            );
            $courses = array();
            $hassurveys = false;
            $invalidcourses = false;
            foreach ($evasyscourses as $evasyscourseinfo) {
                $course = array();
                $course['evasyscoursetitle'] = $evasyssynchronizer->get_course_name($evasyscourseinfo['id']);
                $course['technicalid'] = $evasyssynchronizer->get_course_id($evasyscourseinfo['id']);
                $course['evasyscourseid'] = $evasyscourseinfo['id'];
                $course['c_participants'] = format_string($evasyssynchronizer->get_amount_participants($evasyscourseinfo['id']));
                $rawsurveys = $evasyssynchronizer->get_surveys($evasyscourseinfo['id']);
                $surveys = array();
                foreach ($rawsurveys as $rawsurvey) {
                    $survey = array();
                    $survey['formName'] = format_string($rawsurvey->formName);
                    $survey['surveystatus'] = get_string('surveystatus' . $rawsurvey->surveyStatus, 'block_evasys_sync');
                    $survey['amountOfCompleteForms'] = format_string($rawsurvey->amountOfCompletedForms);
                    if ($record !== false && $record->get('state') == course_evaluation_allocation::STATE_AUTO_CLOSED && $rawsurvey->surveyStatus == 'open') {
                        $data['warning'] = 'true';
                        $data['startdisabled'] = "";
                        $data['enddisabled'] = "";
                    }
                    if ($record === false && $rawsurvey->surveyStatus == 'closed') {
                        $data['startdisabled'] = 'disabled';
                        $data['enddisabled'] = 'disabled';
                        $data['startoption'] = true;
                    }

                    $surveys[] = $survey;
                    $hassurveys = true;
                }

                // If any course has an unkown technical id, we don't want to allow synchronization.
                if ($course['technicalid'] == "Unknown") {
                    $invalidcourses = true;
                }

                $course['surveys'] = $surveys;
                $courses[] = $course;
            }
            $data['courses'] = $courses;

            /* In case of the manual workflow, we can start synchronisation also, if no surveys are registered, yet.
             * In case of the automated workflow, we require surveys
             * in order to be able to automatically trigger the evaluation. */
            $data['showcontrols'] = ($hassurveys || !$ismodeautomated) && count($evasyscourses) > 0 && !$invalidcourses;

            $this->content->text .= $OUTPUT->render_from_template("block_evasys_sync/block", $data);
        } else {
            $hasextras = \block_evasys_sync\course_evasys_courses_allocation::record_exists_select("course = {$this->page->course->id} AND NOT evasyscourses = ''");
            if ($inlsf or $hasextras) {
                $href = new moodle_url('/course/view.php', array('id' => $this->page->course->id, "evasyssynccheck" => true));
                $this->content->text .= $OUTPUT->single_button($href, get_string('checkstatus', 'block_evasys_sync'), 'get');
            } else {
                $this->content->text .= $OUTPUT->render_from_template("block_evasys_sync/coursemapping", array(
                    "courseid" => $this->page->course->id,
                    "sesskey" => sesskey()
                ));
            }
        }
        $this->content->footer = '';
        return $this->content;
    }
    /**
     * The Block is only available at course-view pages
     *
     * @return array
     */
    public function applicable_formats() {
        return array('course-view' => true, 'mod' => false, 'my' => false);
    }

    /**
     * Allow the block to have a configuration page
     *
     * @return boolean
     */
    public function has_config() {
        return true;
    }
}

