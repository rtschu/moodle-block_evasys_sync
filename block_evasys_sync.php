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

        if ($evasyssynccheck === 1) {
            $evasyssynchronizer = new \block_evasys_sync\evasys_synchronizer($this->page->course->id);

            $this->content->text .= html_writer::div(html_writer::span(
                get_string('evacourseid', 'block_evasys_sync'), 'emphasize') . ' ' . $evasyssynchronizer->get_evasys_courseid());
            $this->content->text .= html_writer::div(get_string('surveys', 'block_evasys_sync'), 'emphasize');
            $outputsurveys = array();
            $surveys = $evasyssynchronizer->get_surveys();

            if (empty($surveys)) {
                $this->content->text .= get_string('nosurveys', 'block_evasys_sync');
            } else {
                foreach ($surveys as &$survey) {
                    $outputsurveys[] = html_writer::div(format_string($survey->formName), 'emphasize') .
                        html_writer::div(html_writer::span(get_string('surveystatus', 'block_evasys_sync'), 'emphasize') . ' ' .
                            // Either "open" or "closed" in the applicable localisation.
                            get_string('surveystatus' . $survey->surveyStatus, 'block_evasys_sync')) .
                        html_writer::div(html_writer::span(get_string('finishedforms', 'block_evasys_sync'), 'emphasize') .' ' .
                            format_string($survey->amountOfCompletedForms));
                }
                $this->content->text .= html_writer::alist($outputsurveys, null, 'ol');

                $this->content->text .= html_writer::div(html_writer::span(
                    get_string('countparticipants', 'block_evasys_sync'), 'emphasize') . ' ' .
                    format_string($evasyssynchronizer->get_amount_participants()));
                $href = new moodle_url('/blocks/evasys_sync/sync.php', array('courseid' => $this->page->course->id));
                $this->content->text .= $OUTPUT->single_button($href, get_string('invitestudents', 'block_evasys_sync'), 'post' );
            }

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
}

