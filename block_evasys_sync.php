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
        global $OUTPUT;
        $evasyssynccheck = optional_param('evasyssynccheck', 0, PARAM_BOOL);
        $status = optional_param('status', "", PARAM_TEXT);
        $mode = (bool) $this->getmode($this->page->course->category);

        if ($this->content !== null) {
            return $this->content;
        }

        $this->content = new stdClass();
        $this->content->text = '';

        $access = has_capability('block/evasys_sync:synchronize', context_course::instance($this->page->course->id));
        $inlsf = !empty($this->page->course->idnumber);
        if (!$access || !$inlsf) {
            return $this->content;
        }

        // If the teacher can start the evaluation directly, we'll want to run some javascript initialization.
        if ($mode) {
            $this->page->requires->js_call_amd('block_evasys_sync/invite_manager', 'init');
        }

        if ($status === 'success') {
            $this->page->requires->js_call_amd('block_evasys_sync/post_dialog', 'show_dialog_success');
        } else if ($status === 'uptodate') {
            $this->page->requires->js_call_amd('block_evasys_sync/post_dialog', 'show_dialog_up_to_date');
        } else if ($status === 'failure') {
            $this->page->requires->js_call_amd('block_evasys_sync/post_dialog', 'show_dialog_failure');
        }

        if ($evasyssynccheck === 1) {
            $evasyssynchronizer = new \block_evasys_sync\evasys_synchronizer($this->page->course->id);
            try {
                $evasyscourseids = $evasyssynchronizer->get_evasys_courseid();
            } catch (Exception $exception) {
                \core\notification::warning(get_string('syncnotpossible', 'block_evasys_sync'));
                $this->content->text .= html_writer::div(get_string('syncnotpossible', 'block_evasys_sync'));
                return $this->content;
            }

            if (!$this->getmode($this->page->course->category)) {
                $href = new moodle_url('/blocks/evasys_sync/sync.php');
            } else {
                $href = new moodle_url('/course/view.php',
                                       array('id' => $this->page->course->id, "evasyssynccheck" => true));
            }
            // Begin form.

            $this->content->text .= "<form action='$href' method='post' id='evasys_block_form'>";
            $this->content->text .= "<input type='hidden' name='sesskey' value='" . sesskey() . "'>";
            $this->content->text .= "<input type='hidden' name='courseid' value='" . $this->page->course->id . "'>";

            $i = 0;
            // Output for each Evasys-course mapped to this moodle course.
            foreach ($evasyscourseids as $evasyscourseid) {
                $this->content->text .= html_writer::div(html_writer::span(
                                                             get_string('evacourseid', 'block_evasys_sync'), 'emphasize') . ' ' . $evasyscourseid);
                $this->content->text .= html_writer::div(html_writer::span(
                                                             get_string('countparticipants', 'block_evasys_sync'), 'emphasize') . ' ' .
                                                         format_string($evasyssynchronizer->get_amount_participants($evasyscourseid)));
                $this->content->text .= html_writer::div(get_string('surveys', 'block_evasys_sync'), 'emphasize');
                $outputsurveys = array();
                $surveys = $evasyssynchronizer->get_surveys($evasyscourseid);

                if (empty($surveys)) {
                    $this->content->text .= get_string('nosurveys', 'block_evasys_sync');
                } else {
                    $readonly = "readonly";
                    foreach ($surveys as &$survey) {
                        // Output for each of those surveys :D.
                        $prefills = \block_evasys_sync\evaluationperiod_survey_allocation::get_record(array('survey' => $survey->id));
                        // Find if dates have been defined before and should be prefilled.
                        if (!$prefills) {
                            $begin = "";
                            $stop = "";
                            $beginmin = $endmin = date("Y-m-d");
                        } else {
                            $begin = (int)$prefills->get("startdate");
                            $stop = (int)$prefills->get("enddate");
                            if ($begin < time()) {
                                $beginmin = date("Y-m-d", $begin);
                            } else {
                                $beginmin = date("Y-m-d");
                            }
                            if ($stop < time()) {
                                $endmin = date("Y-m-d", $stop);
                            } else {
                                $endmin = date("Y-m-d");
                            }
                            $begin = date("Y-m-d", $begin);
                            $stop = date("Y-m-d", $stop);
                        }
                        if (!($survey->surveyStatus == "closed")) {
                            $readonly = "";
                        }
                        $outputsurveys[] =
                            '<span class="emphasize">' . format_string($survey->formName) . '</span> <br/>' .
                            '<span class="emphasize">' . get_string('surveystatus', 'block_evasys_sync') . '</span> ' .
                            get_string('surveystatus' . $survey->surveyStatus, 'block_evasys_sync') . '<br/>' .
                            '<span class="emphasize">' . get_string('finishedforms', 'block_evasys_sync') . '</span> ' . format_string($survey->amountOfCompletedForms) . '<br/>';
                        $i++;
                    }
                    $this->content->text .= html_writer::alist($outputsurveys, null, 'ol');
                    $this->content->text .= "<fieldset>" .
                        "<label for='startDate'>" . get_string('begin', 'block_evasys_sync') . "</label>" .
                        '<input type="date" name="startDate" min="' . $beginmin . '" value="' . $begin . '" ' . $readonly . '/>' .
                        "<label for='endDate'>" . get_string('end', 'block_evasys_sync') . "</label>" .
                        '<input type="date" name="endDate" min="' . $endmin . '" value="' . $stop . '" ' . $readonly . '/>' .
                        '</fieldset>';
                    if ($i > 0) {
                        if (!$mode) {
                            $this->content->text .= "<input type='submit' value='" .
                                get_string('invitestudents', 'block_evasys_sync') . "'/> \n ";
                        } else {
                            $this->content->text .= "<input type='submit' value='" .
                                get_string('direct_invite', 'block_evasys_sync') . "'/> \n";
                        }
                    }
                }
            }
            $this->content->text .= "</form>";
            $addurl = new moodle_url('/blocks/evasys_sync/addcourse.php?', array('id' => $this->page->course->id));
            $this->content->text .= $OUTPUT->single_button($addurl, get_string('change_mapping', 'block_evasys_sync'), 'get');
        } else {
            $href = new moodle_url('/course/view.php', array('id' => $this->page->course->id, "evasyssynccheck" => true));
            $this->content->text .= $OUTPUT->single_button($href, get_string('checkstatus', 'block_evasys_sync'), 'get');
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

    /**
     * @param $category
     * @return bool wether the teacher may set dates for this survey himself.
     * @throws dml_exception
     * @throws moodle_exception
     */
    private function getmode($category) {
        global $DB;
        $mode = $DB->get_record('block_evasys_sync_categories', array('course_category' => $category));
        if ($mode) {
            return (bool) $mode->category_mode;
        } else {
            $parents = \core_course_category::get($category)->get_parents();
            for ($i = count($parents) - 1; $i >= 0; $i--) {
                $mode = $DB->get_record('block_evasys_sync_categories', array('course_category' => $parents[$i]));
                if ($mode) {
                    return (bool) $mode->category_mode;
                }
            }
        }
        $default = get_config('block_evasys_sync', 'default_evasys_mode');
        return $default;
    }
}

