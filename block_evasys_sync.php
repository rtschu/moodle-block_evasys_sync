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
                $this->content->text .= "<form action='$href'>";
                $this->content->text .= "<input type='hidden' name='sesskey' value='" . sesskey() . "'>";
                $this->content->text .= "<input type='hidden' name='courseid' value='" . $this->page->course->id . "'>";
            } else {
                $href = new moodle_url('/course/view.php',
                                       array('id' => $this->page->course->id, "evasyssynccheck" => true, "invite_confirm" => true));
                $this->content->text .= "<form action='$href' method='post' id='evasys_block_form'>";
                $this->content->text .= "<input type='hidden' name='sesskey' value='" . sesskey() . "'>";
                $this->content->text .= "<input type='hidden' name='courseid' value='" . $this->page->course->id . "'>";
            }

            $i = 0;
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
                    foreach ($surveys as &$survey) {
                        $prefills = \block_evasys_sync\evaluationperiod_survey_allocation::get_record(array('survey' => $survey->id));
                        if (!$prefills) {
                            $begin = "";
                            $stop = "";
                            $beginmin = date("Y-m-d");
                            $endmin = date("Y-m-d");
                        } else {
                            $begin = date("Y-m-d", $prefills->get("startdate"));
                            $stop = date("Y-m-d", $prefills->get("enddate"));
                            if ($begin < date("Y-m-d")) {
                                $beginmin = $begin;
                            } else {
                                $beginmin = date("Y-m-d");
                            }
                            if ($stop < date("Y-m-d")) {
                                $endmin = $stop;
                            } else {
                                $endmin = date("Y-m-d");
                            }
                        }
                        $readonly = "";
                        if ($survey->surveyStatus == 'closed') {
                            $readonly = "readonly";
                            if ($begin == "") {
                                $begin = "2000-01-01";
                            }
                            if ($stop == "") {
                                $stop = "2000-01-01";
                            }
                        }
                        $outputsurveys[] =
                            '<span class="emphasize">' . format_string($survey->formName) . '</span> <br/>' .
                            '<span class="emphasize">' . 'Evaluationsstatus' . '</span> ' .
                            get_string('surveystatus' . $survey->surveyStatus, 'block_evasys_sync') . '<br/>' .
                            '<span class="emphasize">' . 'Ausgefüllt' . '</span> ' . format_string($survey->amountOfCompletedForms) . '<br/>' .
                            "<fieldset>" .
                            "<div class='custom1'>" .
                            "<label for='startDate$i'>Beginn</label>" .
                            '<input type="date" name="startDate' . $i . '" min="' . $beginmin . '" value="' . $begin . '" ' . $readonly . '/>' .
                            "</div>" .
                            "<div class='custom1'>" .
                            "<label for='endDate$i'>Ende</label>" .
                            '<input type="date" name="endDate' . $i . '" min="' . $endmin . '" value="' . $stop . '" ' . $readonly . '/>' .
                            "</div>" .
                            '</fieldset>';
                        $i++;
                    }
                    $this->content->text .= html_writer::alist($outputsurveys, null, 'ol');
                }
                $this->content->text .= "<input type='hidden' name='count' value='$i'>";
            }
            if (!$mode) {
                $this->content->text .= "<input type='submit' value='".get_string('invitestudents', 'block_evasys_sync')."'> \n "
                                      . "</form>";
            } else {
                $this->content->text .= "<input type='submit' value='".get_string('direct_invite', 'block_evasys_sync')."'> \n"
                                       . "</form>";
            }
            $addurl = new moodle_url('/blocks/evasys_sync/addcourse.php?', array('id' => $this->page->course->id));
            $this->content->text .= $OUTPUT->single_button($addurl, 'Zuordnung ändern', 'get');
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

