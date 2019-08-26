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
$course = get_course($id);

require_login($id);
require_capability('block/evasys_sync:modifymapping', context_course::instance($id));

$PAGE->set_url('/blocks/evasys_sync/addcourse.php');
$PAGE->set_course($course);
$PAGE->set_context(context_course::instance($id));
$PAGE->set_title(get_string('add_course_header', 'block_evasys_sync'));

$record = $DB->get_record('block_evasys_sync_courseeval', array('course' => $id));
if ($record !== false and ($record->state == 1 or $record->state == 2) and !is_siteadmin()) {
    echo $OUTPUT->header();
    echo get_string('forbidden', 'block_evasys_sync');
    echo $OUTPUT->footer();
    return;
}

$mform = new \block_evasys_sync\add_course_form();
$mform->init($id);

$pid = $DB->get_field('block_evasys_sync_courses', 'id', array('course' => $id));
$prefill = array();
$pre = array();
if (!$pid) {
    $persistent = new \block_evasys_sync\course_evasys_courses_allocation(0);
} else {
    $persistent = new \block_evasys_sync\course_evasys_courses_allocation($pid);
    $pre = explode('#', $persistent->get('evasyscourses'));
    // Last array value is allways an empty string...
    array_pop($pre);
    foreach ($pre as $value) {
        $prefill[$value] = 1;
    }
}

if ($mform->is_validated()) {
    global $DB, $USER;
    $data = $mform->get_data();
    if (is_object($data)) {
        $data = (Array) $data;
    }
    // Eventually, this string will contain the final mapping.
    $magicstring = '';

    // Pop the submitbutton.
    array_pop($data);

    // Add all courses that were already mapped prior to the current change (even if the logged in user does not own these courses herself).
    foreach ($pre as $entry) {
        if (!is_course_of_teacher($entry, $USER->username) && !is_siteadmin()) {
            $magicstring .= $entry . "#";
        }
    }

    // Now add (selected) courses that the logged in user has authority over.
    foreach ($data as $key => $value) {
        if ($value) {
            if (is_siteadmin() || is_course_of_teacher($key, $USER->username)) {
                $magicstring .= $key . "#";
            }
        }
    }

    $persistent->set('course',  $id);
    $persistent->set('evasyscourses', $magicstring);
    $persistent->save();
    $redirecturl = new moodle_url('/course/view.php', array('id' => $id, 'evasyssynccheck' => 1));
    redirect($redirecturl, get_string('selection_success', 'block_evasys_sync'));
}

echo $OUTPUT->header();
$mform->set_data($prefill);
$mform->display();
echo $OUTPUT->footer();
