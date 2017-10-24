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

/**
 * Settings for the evasys_sync block
 *
 * @package block_evasys_sync
 * @license http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

require_once(__DIR__ . '/../../config.php');
require_once($CFG->libdir . '/adminlib.php');
require_once($CFG->dirroot.'/course/lib.php');
$delcat = optional_param('d', 0, PARAM_INT);
$confirm = optional_param('c', 0 , PARAM_INT);
require_login();

// Set the URL that should be used to return to this page.
$PAGE->set_url('/blocks/evasys_sync/adminsettings');

if (has_capability('moodle/site:config', context_system::instance())) {
    admin_externalpage_setup('block_evasys_sync');

    if(!empty($delcat) && !empty($confirm)) {
        // Course category user is deleted
        $DB->delete_records('block_evasys_sync_categories', array('course_category' => $delcat));
        redirect($PAGE->url);
        exit();
    }

    $mform = new block_evasys_sync\admin_form();

    if(!empty($delcat)) {
        // Deletion has to be confirmed.

        // Print a confirmation message.
        echo $OUTPUT->header();
        echo $OUTPUT->heading(get_string('settings', 'block_evasys_sync'));
        echo $OUTPUT->confirm(get_string("delete_confirm", "block_evasys_sync"),
                "adminsettings.php?d=$delcat&c=$delcat",
                'adminsettings.php');
        echo $OUTPUT->footer();
        exit();
    }
    // Form is submitted.
    else if ($data = $mform->get_data()) {
        // Added course category
        if(isset($data->addcatbutton)) {
            $category = $data->evasys_cc_select;
            $user = $data->evasys_cc_user;

            // Insert new record.
            $DB->execute('INSERT INTO {block_evasys_sync_categories} VALUES (?,?)', array($category, $user));
            redirect($PAGE->url);
            exit();
        }
        // Form is submitted.
         else if(isset($data->submitbutton)) {
            if (isset($data->evasys_wsdl_url)) {
                set_config('evasys_wsdl_url', $data->evasys_wsdl_url, 'block_evasys_sync');
            }
            if (isset($data->evasys_soap_url)) {
                set_config('evasys_soap_url', $data->evasys_soap_url, 'block_evasys_sync');
            }
            if (isset($data->evasys_username)) {
                set_config('evasys_username', $data->evasys_username, 'block_evasys_sync');
            }
            if (isset($data->evasys_password)) {
                set_config('evasys_password', $data->evasys_password, 'block_evasys_sync');
            }
            if (isset($data->default_evasys_moodleuser)) {
                set_config('default_evasys_moodleuser', $data->default_evasys_moodleuser, 'block_evasys_sync');
            }

            $categories = $DB->get_records_sql('SELECT course_category, userid FROM {block_evasys_sync_categories}');
            foreach ($categories as $category) {
                $newvalue = 'category_' . $category->course_category;
                $oldvalue = $DB->get_record('block_evasys_sync_categories', array('course_category' => $category->course_category));

                // TODO nicht mehr so machen sondern über kreuz
                if ($data->$newvalue === get_string('default', 'block_evasys_sync')) {
                    // Reset to default user.
                    if ($oldvalue) {
                        $DB->delete_records('block_evasys_sync_categories', array('course_category' => $category->course_category));
                    }
                } else {
                    if (!$oldvalue) {
                        // Insert new record.
                        $record = new stdClass();
                        $record->course_category = $category->course_category;
                        $record->userid = $data->$newvalue;
                        $DB->insert_record('block_evasys_sync_categories', $record, false);
                    } else if ($data->$newvalue != $oldvalue->userid) {
                        // Update record.
                        $DB->execute('UPDATE {block_evasys_sync_categories} SET userid=' . $data->$newvalue . ' WHERE course_category=' . $category->id);
                    }
                }
            }
        }
    }

    echo $OUTPUT->header();
    echo $OUTPUT->heading(get_string('settings', 'block_evasys_sync'));
    $mform->display();

    echo $OUTPUT->footer();
}
