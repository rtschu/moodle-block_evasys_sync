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
 * Block evasys_sync renderer.
 * @package   block_evasys_sync
 * @license   http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */
class block_evasys_sync_renderer extends plugin_renderer_base {

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

        $categories = $this->getcategories();
        foreach ($categories as $category) {
            $row = new \html_table_row();

            $categoryname = html_writer::tag('div', $category->name);
            $attributes = array('type' => 'hidden', 'name' => 'categoryid', 'value' => $category->id);
            $categoryname .= html_writer::empty_tag('input', $attributes) . "\n";
            $categoryname = new \html_table_cell($categoryname);
            $moodleuser = html_writer::empty_tag('input', array('type' => 'text',
                'id' => 'moodleuser', 'name' => 'moodleuser', 'value' => $this->getuser($category->id)));
            $moodleuser = new \html_table_cell($moodleuser);

            $row->cells = array(
                $categoryname, $moodleuser
            );
            $table->data[] = $row;
        }
        return html_writer::table($table);
    }

    private function getcategories() {
        global $DB;
        $categories = $DB->get_records_sql('SELECT id, name FROM {course_categories}');
        return $categories;
    }

    /**
     * @param $id
     * @return string
     */
    private function getuser($id) {
        global $DB;
        $user = $DB->get_record('evasys_sync_categories', array('course_category' => $id));
        if ($user !== false) {
            return $user->userid;
        } else {
            return 'Default';
        }
    }
}
