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

// This shouldn't be visited but accessed by ajax requests.
require_once('../../config.php');
require_login();
require_sesskey();

$timezone = "Europe/Berlin";
$decoder = array(
    get_string('January', 'block_evasys_sync') => 1,
    get_string('February', 'block_evasys_sync') => 2,
    get_string('March', 'block_evasys_sync') => 3,
    get_string('April', 'block_evasys_sync') => 4,
    get_string('May', 'block_evasys_sync') => 5,
    get_string('June', 'block_evasys_sync') => 6,
    get_string('July', 'block_evasys_sync') => 7,
    get_string('August', 'block_evasys_sync') => 8,
    get_string('September', 'block_evasys_sync') => 9,
    get_string('October', 'block_evasys_sync') => 10,
    get_string('November', 'block_evasys_sync') => 11,
    get_string('December', 'block_evasys_sync') => 12,
);

$courseid = required_param('courseid', PARAM_INT);
$course = get_course($courseid);
if (\block_evasys_sync\evasys_inviter::getmode($course->category) == 0) {
    echo "wrong mode";
}
$DB->get_record('course', array('id' => $courseid), 'id', MUST_EXIST);
$PAGE->set_context(context_course::instance($courseid));
require_capability('block/evasys_sync:synchronize', context_course::instance($courseid));
$PAGE->set_url('/blocks/evasys_sync/sync.php');
$invitedirect = optional_param("direct_invite", false, PARAM_BOOL);
$onlyend = optional_param('only_end', false, PARAM_BOOL);
$endyear = required_param('year_end', PARAM_TEXT);
$endmonth = required_param('month_end', PARAM_TEXT);
$endday = required_param('day_end', PARAM_TEXT);
$endhour = required_param('hour_end', PARAM_TEXT);
$endmin = required_param('minute_end', PARAM_TEXT);
$enddate = new DateTime();
$enddate->setTimezone(new DateTimeZone($timezone));
$enddate->setDate($endyear, $decoder[$endmonth], $endday);
$enddate->setTime($endhour, $endmin);
$end = $enddate->getTimestamp();
if ($invitedirect) {
    $startdate = new DateTime();
    $start = $startdate->getTimestamp();
} else {
    $startyear = required_param('year_start', PARAM_TEXT);
    $startmonth = required_param('month_start', PARAM_TEXT);
    $startday = required_param('day_start', PARAM_TEXT);
    $starthour = required_param('hour_start', PARAM_TEXT);
    $startmin = required_param('minute_start', PARAM_TEXT);
    $startdate = new DateTime();
    $startdate->setTimezone(new DateTimeZone($timezone));
    $startdate->setDate($startyear, $decoder[$startmonth], $startday);
    $startdate->setTime($starthour, $startmin);
    $start = $startdate->getTimestamp();
}

$time = time();
if ($start > $end) {
    echo "Start after end";
    return;
}
if ($time > $end) {
    echo "End in the past";
    return;
}
if (!$invitedirect && !$onlyend && $time > $start) {
    echo "Start in the past";
    return;
}

$persistentid = $DB->get_field("block_evasys_sync_courseeval", "id", array('course' => $courseid));
if ($persistentid) {
    $record = new \block_evasys_sync\course_evaluation_allocation($persistentid);
    if (!$onlyend) {
        $record->set('startdate', $start);
        $record->set('state', 0);
    }
    $record->set('enddate', $end);
    $record->update();
} else {
    $data = new stdClass();
    $data->course = $courseid;
    $data->startdate = $start;
    $data->enddate = $end;
    $data->state = 0;
    $record = new \block_evasys_sync\course_evaluation_allocation(0, $data);
    $record->create();
}

if ($invitedirect) {
    $inviter = \block_evasys_sync\evasys_inviter::get_instance();
    $inviter->open_moodle_courses(array($courseid));
}

global $USER, $PAGE;
$event = \block_evasys_sync\event\evaluationperiod_set::create(array(
        'userid' => $USER->id,
        'courseid' => $courseid,
        'context' => \context_course::instance($courseid),
        'other' => array(
            'start' => $startdate->format('d-m-Y H:i:s'),
            'end' => $enddate->format('d-m-Y H:i:s'),
        )
    )
);
$event->trigger();
if ($invitedirect) {
    echo "success inviting";
} else {
    echo "success";
}
