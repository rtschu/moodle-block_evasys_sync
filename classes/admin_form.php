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
 * @license http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

namespace block_evasys_sync;

use moodleform;
use html_writer;
use html_table_cell;

defined('MOODLE_INTERNAL') || die;

require_once($CFG->libdir . '/formslib.php');

class admin_form extends moodleform {
    protected function definition() {
        $mform = $this->_form;

        // Username.
        $name = 'evasys_username';
        $title = get_string('settings_username', 'block_evasys_sync');
        $description = get_string('settings_usernamedesc', 'block_evasys_sync');
        $mform->addElement('text', $name, $title);
        $mform->setType($name, PARAM_TEXT);

        // Password.
        $name = 'evasys_password';
        $title = get_string('settings_password', 'block_evasys_sync');
        $description = get_string('settings_passworddesc', 'block_evasys_sync');
        $mform->addElement('passwordunmask', $name, $title);

        // SOAP URL.
        $name = 'evasys_soap_url';
        $title = get_string('settings_soap_url', 'block_evasys_sync');
        $description = get_string('settings_soap_urldesc', 'block_evasys_sync');
        $mform->addElement('text', $name, $title);
        $mform->setType($name, PARAM_TEXT);

        // WSDL URL.
        $name = 'evasys_wsdl_url';
        $title = get_string('settings_wsdl_url', 'block_evasys_sync');
        $description = get_string('settings_wsdl_urldesc', 'block_evasys_sync');
        $mform->addElement('text', $name, $title);
        $mform->setType($name, PARAM_TEXT);

        // Default Learnweb user for notifications.
        $name = 'default_evasys_moodleuser';
        $title = get_string('settings_moodleuser', 'block_evasys_sync');
        $description = get_string('settings_moodleuserdesc', 'block_evasys_sync');
        $mform->addElement('text', $name, $title);
        $mform->setType($name, PARAM_INT);
        $mform->setDefault($name, 25989);

        // Course category select
        $name = 'evasys_cc_select';
        $title = get_string('settings_cc_select', 'block_evasys_sync');
        $mform->addElement('select', $name, $title, make_categories_options());

        $name = 'evasys_cc_user';
        $title = get_string('settings_cc_user', 'block_evasys_sync');
        $mform->addElement('text', $name, $title);
        $mform->setType($name, PARAM_INT);

        // Add Button
        $mform->addElement('submit', 'addcatbutton', get_string('addcat', 'block_evasys_sync'));

        // Add Table
        $mform->addElement('html', $this->tablehead());
        $this->table_body();

        $mform->addElement('submit', 'submitbutton', get_string('submit', 'block_evasys_sync'));
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
        $categories = $this->getcategories();
        foreach ($categories as $category) {
            $mform->addElement('html', '<tr>');
            $mform->addElement('html', '<td class="cell c0"><div>' . $category->name . '</div></td>');
            $mform->addElement('html', '<td class="cell c1">');
            $mform->addElement('text', 'category_' . $category->course_category, null);
            $mform->setType('category_' . $category->course_category, PARAM_TEXT);
            $mform->setDefault('category_' . $category->course_category, $category->userid);
            $mform->addElement('html', '</td><td class="cell c2 lastcol">');
            $link = '/blocks/evasys_sync/adminsettings.php';
            $editurl = new \moodle_url($link, array('d' => $category->course_category));
            $text = get_string('delete_user_text', 'block_evasys_sync');
            $mform->addElement('html', '<a href="' . $editurl->out() . '">' . $text . '</a></td></tr>');
        }
        $mform->addElement('html', '</tbody>');
        $mform->addElement('html', '</table>');
    }

    /**
     * Returns all course categories to which a custom user is assigned.
     * @return array
     */
    private function getcategories() {
        global $DB;
        $categories = $DB->get_records_sql('SELECT {block_evasys_sync_categories}.course_category, {block_evasys_sync_categories}.userid, {course_categories}.name 
                                                FROM {block_evasys_sync_categories} 
                                                INNER JOIN {course_categories} 
                                                WHERE {block_evasys_sync_categories}.course_category = {course_categories}.id');
        return $categories;
    }
}