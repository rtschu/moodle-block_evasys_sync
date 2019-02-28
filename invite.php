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

$PAGE->set_url('/blocks/evasys_sync/sync.php');
$DB->get_record('course', array('id' => $courseid), 'id', MUST_EXIST);

$PAGE->set_context(context_course::instance($courseid));
require_capability('block/evasys_sync:synchronize', context_course::instance($courseid));

$returnurl = new moodle_url($CFG->wwwroot . '/course/view.php');
$returnurl->param('id', $courseid);
$returnurl->param('evasyssynccheck', 1);

try {
    $evasyssynchronizer = new \block_evasys_sync\evasys_synchronizer($courseid);
    $result = $evasyssynchronizer->invite_all();
    echo($result);

} catch (Exception $exception) {
    debugging($exception);
    echo("Emails konnten nicht versendet werden");
    exit();
}