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
        // TODO double check.
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
            $mode = (bool) \block_evasys_sync\evasys_inviter::getmode($this->page->course->category);
            // If the teacher can start the evaluation directly, we'll want to run some javascript initialization.
            if ($mode) {
                $this->page->requires->js_call_amd('block_evasys_sync/invite_manager', 'init');
            }
            $evasyssynchronizer = new \block_evasys_sync\evasys_synchronizer($this->page->__get('course')->id);

            try {
                $evasyscourseinfos = $evasyssynchronizer->get_evasys_courseid();
            } catch (Exception $exception) {
                \core\notification::warning(get_string('syncnotpossible', 'block_evasys_sync'));
                $this->content->text .= html_writer::div(get_string('syncnotpossible', 'block_evasys_sync'));
                return $this->content;
            }

            if (!$mode) {
                $href = new moodle_url('/blocks/evasys_sync/sync.php');
            } else {
                $href = new moodle_url('/course/view.php',
                                       array('id' => $this->page->course->id, "evasyssynccheck" => true));
            }

            // Get Status.
            $startdisabled = "";
            $enddisabled = "";
            $start = time();
            $end = time();
            global $DB;
            $record = $DB->get_record('block_evasys_sync_courseeval', array('course' => $this->page->course->id));
            if (is_object($record)) {
                if ($record->state > 0) {
                    $startdisabled = "disabled";
                }
                if ($record->state > 1) {
                    $enddisabled = "disabled";
                }
                if (isset($record->startdate)) {
                    $start = $record->startdate;
                }
                if (isset($record->enddate)) {
                    $end = $record->enddate;
                }
            }
            $this->page->requires->js_call_amd('block_evasys_sync/initialize', 'init', array($start, $end));
            // Begin form.
            $data = array(
                'href' => $href,
                'sesskey' => sesskey(),
                'courseid' => $this->page->course->id,
                'direct' => $mode,
                'startdisabled' => $startdisabled,
                'enddisabled' => $enddisabled,
                'startoption' => $enddisabled xor $startdisabled,
                'coursemappingenabled' => !$startdisabled or is_siteadmin()
            );
            $courses = array();
            $showcontrols = false;
            foreach ($evasyscourseinfos as $evasyscourseinfo) {
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
                    if (is_object($record) and $record->state == 2 and $rawsurvey->surveyStatus == 'open') {
                        $data['warning'] = 'true';
                        $data['startdisabled'] = "";
                        $data['enddisabled'] = "";
                    }
                    array_push($surveys, $survey);
                    $showcontrols = true;
                }
                $course['surveys'] = $surveys;
                array_push($courses, $course);
            }
            $data['courses'] = $courses;
            $data['showcontrols'] = $showcontrols;
            $this->content->text = $OUTPUT->render_from_template("block_evasys_sync/block", $data);
        } else {
            $hasextras = \block_evasys_sync\course_evaluation_allocation::record_exists_select("course = {$this->page->course->id}");
            if ($inlsf or $hasextras) {
                $href = new moodle_url('/course/view.php', array('id' => $this->page->course->id, "evasyssynccheck" => true));
                $this->content->text .= $OUTPUT->single_button($href, get_string('checkstatus', 'block_evasys_sync'), 'get');
            } else {
                $this->content->text = $OUTPUT->render_from_template("block_evasys_sync/coursemapping", array(
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

