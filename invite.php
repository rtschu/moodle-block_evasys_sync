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
$courseid = required_param('courseid', PARAM_INT);
$count = required_param('count', PARAM_INT);
$dates = array();
for ($i = 0; $i < $count; $i++) {
    $start = required_param('startDate' . $i, PARAM_TEXT);
    $end = required_param('endDate' . $i, PARAM_TEXT);
    if ($start == "" or $end == "") {
        die("not_enough_dates");
    }
    $dates[] = array("start" => $start,
        "end" => $end);
}

$PAGE->set_url('/blocks/evasys_sync/sync.php');
$DB->get_record('course', array('id' => $courseid), 'id', MUST_EXIST);

$PAGE->set_context(context_course::instance($courseid));
require_capability('block/evasys_sync:synchronize', context_course::instance($courseid));

try {
    $evasyssynchronizer = new \block_evasys_sync\evasys_synchronizer($courseid);
    if ($evasyssynchronizer->sync_students()||true) { // TODO.
        try {
            $result = $evasyssynchronizer->invite_all($dates);
        } catch (\InvalidArgumentException $e) {
            die('date_in_the_past');
        }
        echo($result);
    } else {
        die("up_to_date");
    }
} catch (Exception $exception) {
    debugging($exception);
    echo(get_string('content_failure', 'block_evasys_sync'));
    exit();
}
