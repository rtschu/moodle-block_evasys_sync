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

require_course_login($id);
require_capability('block/evasys_sync:modifymapping', context_course::instance($id));
$PAGE->set_pagelayout('incourse');
$PAGE->set_url('/blocks/evasys_sync/addcourse.php', ['id' => $id]);
$PAGE->set_context(context_course::instance($id));
$PAGE->set_title(get_string('add_course_header', 'block_evasys_sync'));

$record = $DB->get_record('block_evasys_sync_courseeval', array('course' => $id));
if ($record !== false and ($record->state > \block_evasys_sync\course_evaluation_allocation::STATE_AUTO_NOTOPENED) and !is_siteadmin()) {
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
    require_sesskey();

    global $DB, $USER, $pgDB;
    $data = $mform->get_data();
    if (is_object($data)) {
        $data = (Array) $data;
    }
    // Build mapping between moodle and evasys courses.
    $mapping = [];

    // Pop the submitbutton.
    array_pop($data);

    // Connect to lsf database.
    $pgDB->connect();

    // Once retrieve the teachers course list in order to search for its values later.
    $coursesofteacher = get_teachers_course_list($USER->username, false, true);

    // Add all courses that were already mapped prior to the current change (even if the logged in user does not own these courses herself).
    foreach ($pre as $veranstid) {
        $iscourseofteacher = !empty($courses[$veranstid]);
        if (!$iscourseofteacher && !is_siteadmin()) {
            $mapping[] = $veranstid;
        }
    }

    // Now add (selected) courses that the logged in user has authority over.
    foreach ($data as $veranstid => $value) {
        if ($value) {
            $iscourseofteacher = !empty($courses[$veranstid]);
            if (is_siteadmin() || $iscourseofteacher) {
                $mapping[] = $veranstid;
            }
        }
    }

    // Dispose connection to lsf database.
    $pgDB->dispose();

    $mappingstring = implode("#", $mapping);

    $persistent->set('course',  $id);
    $persistent->set('evasyscourses', $mappingstring);
    $persistent->save();
    $redirecturl = new moodle_url('/course/view.php', array('id' => $id, 'evasyssynccheck' => 1));
    redirect($redirecturl, get_string('selection_success', 'block_evasys_sync'));
}

echo $OUTPUT->header();
$mform->set_data($prefill);
$mform->display();
echo $OUTPUT->footer();
