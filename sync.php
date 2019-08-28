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
use block_evasys_sync\date_decoder;

require_once('../../config.php');

require_login();
require_sesskey();
$courseid = required_param('courseid', PARAM_INT);

if (optional_param('only_end', false, PARAM_BOOL)) {
    // Existing start date should not be changed; just the end date. Fetch start date from record.
    $record = course_evaluation_allocation::get_record_by_course($courseid);
    $startdate = new \DateTime('@' . $record->get('startdate'), \core_date::get_server_timezone_object());
} else {
    $startyear = required_param('year_start', PARAM_TEXT);
    $startmonth = date_decoder::decode_from_localised_string(required_param('month_start', PARAM_TEXT));
    $startday = required_param('day_start', PARAM_TEXT);
    $starthour = required_param('hour_start', PARAM_TEXT);
    $startmin = required_param('minute_start', PARAM_TEXT);

    $startdate = new DateTime();
    $startdate->setTimezone(\core_date::get_server_timezone_object());
    $startdate->setDate($startyear, $startmonth, $startday);
    $startdate->setTime($starthour, $startmin);
    if (time() > $startdate->getTimestamp()) {
        // Start date is in the past; change to now (just for the record).
        $startdate = new \DateTime('now', \core_date::get_server_timezone_object());
    }
}

$endyear = required_param('year_end', PARAM_TEXT);
$endmonth = date_decoder::decode_from_localised_string(required_param('month_end', PARAM_TEXT));
$endday = required_param('day_end', PARAM_TEXT);
$endhour = required_param('hour_end', PARAM_TEXT);
$endmin = required_param('minute_end', PARAM_TEXT);

$enddate = new DateTime();
$enddate->setTimezone(\core_date::get_server_timezone_object());
$enddate->setDate($endyear, $endmonth, $endday);
$enddate->setTime($endhour, $endmin);

$dates = ["start" => $startdate->getTimestamp(), "end" => $enddate->getTimestamp()];

$PAGE->set_url('/blocks/evasys_sync/sync.php');
$DB->get_record('course', array('id' => $courseid), 'id', MUST_EXIST);

$PAGE->set_context(context_course::instance($courseid));
require_capability('block/evasys_sync:synchronize', context_course::instance($courseid));

$returnurl = new moodle_url($CFG->wwwroot . '/course/view.php');
$returnurl->param('id', $courseid);
$returnurl->param('evasyssynccheck', 1);

try {
    if (count_enrolled_users(context_course::instance($courseid), 'block/evasys_sync:mayevaluate') == 0) {
        $returnurl->param('status', 'nostudents');
        redirect($returnurl, get_string('syncnostudents', 'block_evasys_sync'), 0);
        exit();
    }

    $evasyssynchronizer = new \block_evasys_sync\evasys_synchronizer($courseid);
    $newparticipantsadded = $evasyssynchronizer->sync_students();
    $datechanged = $evasyssynchronizer->set_evaluation_period($dates);
    if ($newparticipantsadded || $datechanged) {
        $evasyssynchronizer->notify_evaluation_responsible_person($dates, $newparticipantsadded, $datechanged);

        // Log event.
        $event = \block_evasys_sync\event\evaluation_requested::create(array(
            'userid' => $USER->id,
            'courseid' => $courseid,
            'context' => \context_course::instance($courseid),
        ));
        $event->trigger();

        $returnurl->param('status', 'success');
        redirect($returnurl, get_string('syncsucessful', 'block_evasys_sync'), 0);
        exit();
    } else {
        $returnurl->param('status', 'uptodate');
        redirect($returnurl, get_string('syncalreadyuptodate', 'block_evasys_sync'), 0);
        exit();
    }
} catch (Exception $exception) {
    debugging($exception);
    $returnurl->param('status', 'failure');
    notice(get_string('syncnotpossible', 'block_evasys_sync'), $returnurl);
    exit();
}
