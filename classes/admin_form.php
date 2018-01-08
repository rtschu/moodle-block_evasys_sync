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
 * Evasys sync block admin form.
 *
 * @package block_evasys_sync
 * @copyright 2017 Tamara Gunkel
 * @license http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

namespace block_evasys_sync;

use moodleform;
use html_writer;
use html_table_cell;

defined('MOODLE_INTERNAL') || die;

require_once($CFG->libdir . '/formslib.php');
require_once($CFG->libdir . '/coursecatlib.php');

class admin_form extends moodleform {
    protected function definition() {
        $mform = $this->_form;

        $mform->addElement('html', '<div id="adminsettings">');

        // Username.
        $name = 'evasys_username';
        $title = get_string('settings_username', 'block_evasys_sync');
        $mform->addElement('text', $name, $title);
        $mform->setType($name, PARAM_TEXT);

        // Password.
        $name = 'evasys_password';
        $title = get_string('settings_password', 'block_evasys_sync');
        $mform->addElement('passwordunmask', $name, $title);

        // SOAP URL.
        $name = 'evasys_soap_url';
        $title = get_string('settings_soap_url', 'block_evasys_sync');
        $mform->addElement('text', $name, $title);
        $mform->setType($name, PARAM_TEXT);

        // WSDL URL.
        $name = 'evasys_wsdl_url';
        $title = get_string('settings_wsdl_url', 'block_evasys_sync');
        $mform->addElement('text', $name, $title);
        $mform->setType($name, PARAM_TEXT);

        // Default Learnweb user for notifications.
        $name = 'default_evasys_moodleuser';
        $title = get_string('settings_moodleuser', 'block_evasys_sync');
        $mform->addElement('text', $name, $title);
        $mform->setType($name, PARAM_INT);
        $mform->setDefault($name, 25989);

        // Heading Add Category.
        $mform->addElement('html', '<h3>' . get_string('hd_user_cat', 'block_evasys_sync') . '</h3>');

        // Course category select.
        $name = 'evasys_cc_select';
        $title = get_string('settings_cc_select', 'block_evasys_sync');
        $mform->addElement('select', $name, $title, $this->getunassignedcats());

        $name = 'evasys_cc_user';
        $title = get_string('settings_cc_user', 'block_evasys_sync');
        $mform->addElement('text', $name, $title);
        $mform->setType($name, PARAM_INT);

        // Add Button.
        $mform->addElement('submit', 'addcatbutton', get_string('addcat', 'block_evasys_sync'));

        // Add Table.
        $mform->addElement('html', $this->tablehead());
        $this->table_body();

        $mform->addElement('submit', 'submitbutton', get_string('submit', 'block_evasys_sync'));

        $mform->addElement('html', '</div>');
    }


    /**
     * Prints the table head (e.g. column names).
     * @return string
     */
    public function tablehead() {
        $attributes['class'] = 'generaltable';
        $attributes['id'] = 'course_category_table';
        $output = html_writer::start_tag('table', $attributes);

        $output .= html_writer::start_tag('thead', array());
        $output .= html_writer::start_tag('tr', array());

        $attributes = array();
        $attributes['class'] = 'header c0';
        $attributes['scope'] = 'col';
        $output .= html_writer::tag('th', get_string('category_name', 'block_evasys_sync'), $attributes);
        $attributes = array();
        $attributes['class'] = 'header c1';
        $attributes['scope'] = 'col';
        $output .= html_writer::tag('th', get_string('responsible_user', 'block_evasys_sync'), $attributes);
        $attributes = array();
        $attributes['class'] = 'header c2 lastcol';
        $attributes['scope'] = 'col';
        $output .= html_writer::tag('th', get_string('delete_category_user', 'block_evasys_sync'), $attributes);

        $output .= html_writer::end_tag('tr');
        $output .= html_writer::end_tag('thead');

        return $output;
    }

    /**
     * Prints course categories and assigned moodle users.
     * @return string
     */
    private function table_body() {
        $mform = $this->_form;

        $mform->addElement('html', '<tbody>');
        $records = $this->getrecords();
        foreach ($records as $record) {
            $mform->addElement('html', '<tr>');
            $mform->addElement('html', '<td class="cell c0"><div>' .
                $this->getcategoryhierachie($record->get('course_category')) .
                '</div></td>');
            $mform->addElement('html', '<td class="cell c1">');

            // Input field.
            $name = 'category_' . $record->get('id');
            $mform->addElement('text', $name, null);
            $mform->setType($name, PARAM_TEXT);
            $mform->setDefault($name, $record->get('userid'));

            $mform->addElement('html', '</td><td class="cell c2 lastcol">');
            $link = '/blocks/evasys_sync/adminsettings.php';
            $editurl = new \moodle_url($link, array('d' => $record->get('id')));
            $text = get_string('delete', 'block_evasys_sync');
            $mform->addElement('html', '<a href="' . $editurl->out() . '">' . $text . '</a></td></tr>');
        }
        $mform->addElement('html', '</tbody>');
        $mform->addElement('html', '</table>');
    }

    /**
     * Returns all course categories to which a custom user is assigned.
     * @return array
     */
    private function getrecords() {
        $records = \block_evasys_sync\user_cat_allocation::get_records();
        return $records;
    }

    /**
     * Returns all course categories to which no custom user is assigend.
     * @return array
     */
    private function getunassignedcats() {
        global $DB;
        $categories = $DB->get_records_sql('SELECT {course_categories}.id, {course_categories}.name
                                                FROM {course_categories}
                                                LEFT JOIN {block_evasys_sync_categories}
                                                ON {block_evasys_sync_categories}.course_category = {course_categories}.id
                                                WHERE {block_evasys_sync_categories}.course_category IS NULL');

        $cat = array();
        foreach ($categories as $category) {
            $cat[$category->id] = $category->name;
        }
        return $cat;
    }

    /**
     * Returns the hierachie of a category as string.
     * @return string
     */
    private function getcategoryhierachie($catid) {
        $text = '';
        $spaces = '';
        $cat = \coursecat::get($catid);
        $parents = $cat->get_parents();
        foreach ($parents as $pcat) {
            $name = \coursecat::get($pcat)->name;
            $text .= $spaces . ' ' . $name . '<br/>';
            $spaces .= '-';
        }
        if (empty($parents)) {
            $text = $cat->name;
        } else {
            $text .= $spaces . ' ' . $cat->name;
        }
        return $text;
    }

    /**
     * Validates the user ids.
     *
     * @param array $data
     * @param array $files
     * @return array
     */
    public function validation($data, $files) {
        $errors = parent::validation($data, $files);

        // Validate user ids.
        $records = \block_evasys_sync\user_cat_allocation::get_records();
        foreach ($records as $allocation) {

            $newvalue = 'category_' . $allocation->get('id');

            if (!\core_user::is_real_user($data[$newvalue], true)) {
                $errors[$newvalue] = get_string('invaliduserid', 'error');
            }
        }

        if (!empty($data['evasys_cc_user'])) {
            if (!\core_user::is_real_user($data['evasys_cc_user'], true)) {
                $errors['evasys_cc_user'] = get_string('invaliduserid', 'error');
            }
        }

        return $errors;
    }
}