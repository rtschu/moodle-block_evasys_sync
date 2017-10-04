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
        global $DB;
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
        $name = 'vasys_wsdl_url';
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

        $mform->addElement('html', $this->tablehead());
        $this->table_body();

        $mform->addElement('submit', 'submitbutton', get_string('submit', 'block_qrcode'));
    }


    public function tablehead() {
        // explicitly assigned properties override those defined via $table->attributes
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
        $attributes['class'] = 'header c1 lastcol';
        $attributes['scope'] = 'col';
        $output .= html_writer::tag('th', get_string('responsible_user', 'block_evasys_sync'), $attributes);


        $output .= html_writer::end_tag('tr');
        $output .= html_writer::end_tag('thead');

        $output .= html_writer::start_tag('tbody');
        $output .= html_writer::tag('tr', '');
        $output .= html_writer::end_tag('tbody');

        return $output;
    }

    /**
     * @return string
     */
    private function table_body() {
        $mform = $this->_form;

        $mform->addElement('html', '<tbody>');
        $categories = $this->getCategories();
        foreach ($categories as $category) {
            $mform->addElement('html', '<tr>');
            $mform->addElement('html', '<td class="cell c0"><div>'.$category->name.'</div></td>');
            $mform->addElement('html', '<td class="cell c1 lastcol">');
            $mform->addElement('text', 'category_' . $category->id, '');
            $mform->setType('category_' . $category->id, PARAM_TEXT);
            $mform->setDefault('category_' . $category->id, $this->getUser($category->id));
            $mform->addElement('html', '</td></tr>');
        }
        $mform->addElement('html', '</tbody>');
        $mform->addElement('html', '</table>');
    }


    /**
     * @return string
     */
    private function category_table() {
        global $DB;
        $table = new \html_table();
        $table->id = 'course_category_table';
        $table->head = array(
            get_string('category_name', 'block_evasys_sync'),
            get_string('responsible_user', 'block_evasys_sync'),
        );
        $table->headspan = array(1, 1);


        $categories = $this->getCategories();
        foreach ($categories as $category) {
            $row = new \html_table_row();

            $categoryname = html_writer::tag('div', $category->name);
            $attributes = array('type' => 'hidden', 'name' => 'categoryid', 'value' => $category->id);
            $categoryname .= html_writer::empty_tag('input', $attributes) . "\n";
            $categoryname = new html_table_cell($categoryname);


            $moodleuser = html_writer::empty_tag('input', array('type' => 'text',
                'id' => 'moodleuser', 'name' => 'moodleuser', 'value' => $this->getUser($category->id)));
            $moodleuser = new html_table_cell($moodleuser);

            $row->cells = array(
                $categoryname, $moodleuser
            );
            $table->data[] = $row;
        }
        return html_writer::table($table);
    }

    private function getCategories() {
        global $DB;
        $categories = $DB->get_records_sql('SELECT id, name FROM {course_categories}');
        return $categories;
    }

    /**
     * @param $id
     * @return string
     */
    private function getUser($id) {
        global $DB;
        $user = $DB->get_record('evasys_sync_categories', array('course_category' => $id));
        if ($user !== false) {
            return $user->userid;
        } else {
            return 'Default';
        }
    }
}