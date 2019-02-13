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

require_once('../../config.php');

require_login();
require_sesskey();
$courseid = required_param('courseid', PARAM_INT);

$PAGE->set_url('/blocks/evasys_sync/sync.php');
$DB->get_record('course', array('id' => $courseid), 'id', MUST_EXIST);

$PAGE->set_context(context_course::instance($courseid));
require_capability('block/evasys_sync:synchronize', context_course::instance($courseid));

$returnurl = $CFG->wwwroot . '/course/view.php?id=' . $courseid . '&evasyssynccheck=1';

try {
    $evasyssynchronizer = new \block_evasys_sync\evasys_synchronizer($courseid);
    if ($evasyssynchronizer->sync_students() || true) {
        $evasyssynchronizer->notify_evaluation_responsible_person();
        redirect($returnurl, get_string('syncsucessful', 'block_evasys_sync'), 1);
    } else {
        redirect($returnurl, get_string('syncalreadyuptodate', 'block_evasys_sync'), 1);
    }
} catch (Exception $exception) {
    debugging($exception);
    notice(get_string('syncnotpossible', 'block_evasys_sync'), $returnurl);
    exit();
}
