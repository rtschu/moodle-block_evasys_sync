<?php
// This file is part of Moodle - http://moodle.org/
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
require_once('classes/add_course_form.php');
$id = required_param('id', PARAM_INT);

require_login();

$PAGE->set_url('/blocks/evasys_sync/addcourse');
$mform = new \block_evasys_sync\add_course_form();
$mform->addid($id);

$pid = $DB->get_field('block_evasys_sync_courses', 'id', array('course' => $id));
if (!$pid) {
    $persistent = new \block_evasys_sync\course_evasys_courses_allocation(0, $data);
} else {
    $persistent = new \block_evasys_sync\course_evasys_courses_allocation($pid);
    $prefill = new stdClass();
    $pre = explode('#', $persistent->get('evasyscourses'));
    array_pop($pre);
    foreach ($pre as $value) {
        $prefill->$value = 1;
    }
}

if ($mform->is_validated()) {
    global $DB;
    $data = $mform->get_data();
    $magicstring = ''; // HILFE?
    foreach ($data as $key => $value) {
        if ($value == 1) {
            $magicstring .= $key . '#';
        }
    }
    $persistent->set('course',  $id);
    $persistent->set('evasyscourses', $magicstring);
    $persistent->save();
}

echo $OUTPUT->header();
$mform->set_data($prefill);
$mform->display();
echo $OUTPUT->footer();