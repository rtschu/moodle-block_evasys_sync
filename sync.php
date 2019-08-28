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

use block_evasys_sync\date_decoder;

require_once('../../config.php');

require_login();
require_sesskey();
$courseid = required_param('courseid', PARAM_INT);

$endyear = required_param('year_end', PARAM_TEXT);
$endmonth = date_decoder::decode_from_localised_string(required_param('month_end', PARAM_TEXT));
$endday = required_param('day_end', PARAM_TEXT);
$endhour = required_param('hour_end', PARAM_TEXT);
$endmin = required_param('minute_end', PARAM_TEXT);

$startyear = required_param('year_start', PARAM_TEXT);
$startmonth = date_decoder::decode_from_localised_string(required_param('month_start', PARAM_TEXT));
$startday = required_param('day_start', PARAM_TEXT);
$starthour = required_param('hour_start', PARAM_TEXT);
$startmin = required_param('minute_start', PARAM_TEXT);

// Prepare formatted dates for email text.
$start = "$startday.$startmonth.$startyear $starthour:$startmin";
$end = "$endday.$endmonth.$endyear $endhour:$endmin";
$dates = ["start" => $start, "end" => $end];

$PAGE->set_url('/blocks/evasys_sync/sync.php');
$DB->get_record('course', array('id' => $courseid), 'id', MUST_EXIST);

$PAGE->set_context(context_course::instance($courseid));
require_capability('block/evasys_sync:synchronize', context_course::instance($courseid));

$returnurl = new moodle_url($CFG->wwwroot . '/course/view.php');
$returnurl->param('id', $courseid);
$returnurl->param('evasyssynccheck', 1);

try {
    $evasyssynchronizer = new \block_evasys_sync\evasys_synchronizer($courseid);
    if ($evasyssynchronizer->sync_students()) {
        $evasyssynchronizer->notify_evaluation_responsible_person($dates);
        $returnurl->param('status', 'success');
        redirect($returnurl, get_string('syncsucessful', 'block_evasys_sync'), 1);
    } else {
        if (count_enrolled_users(context_course::instance($courseid), 'block/evasys_sync:mayevaluate') != 0) {
            $returnurl->param('status', 'uptodate');
            redirect($returnurl, get_string('syncalreadyuptodate', 'block_evasys_sync'), 1);
        } else {
            $returnurl->param('status', 'nostudents');
            redirect($returnurl, get_string('syncnostudents', 'block_evasys_sync'), 1);
        }
    }
} catch (Exception $exception) {
    debugging($exception);
    $returnurl->param('status', 'failure');
    notice(get_string('syncnotpossible', 'block_evasys_sync'), $returnurl);
    exit();
}
