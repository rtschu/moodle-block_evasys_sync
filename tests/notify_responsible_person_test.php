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
 * PHPUnit evasys testcase
 * @package block_evasys_sync
 * @category test
 * @copyright 2017 T Gunkel
 * @license http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */
defined('MOODLE_INTERNAL') || die();

/**
 * PHPUnit evasys testcase
 * @package block_evasys_sync
 * @category test
 * @copyright 2017 T Gunkel
 * @license http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */
class block_evasys_sync_notify_testcase extends advanced_testcase {
    protected $courseid;

    /**
     * @runInSeparateProcess
     */
    public function test_create_image() {
        global $DB;
        $this->resetAfterTest(true);

        $generator = $this->getDataGenerator();
        $categoryone = $generator->create_category();
        $categorytwo = $generator->create_category();
        $subcategoryone = $generator->create_category(array('parent' => $categoryone->id));
        $subsubcategoryone = $generator->create_category(array('parent' => $subcategoryone->id));
        $defaultuser = $generator->create_user();
        $userone = $this->getDataGenerator()->create_user();
        $usersubone = $this->getDataGenerator()->create_user();
        $usersubsubone = $this->getDataGenerator()->create_user();
        set_config('default_evasys_moodleuser', $defaultuser->id, 'block_evasys_sync');

        $courseone = $this->getDataGenerator()->create_course(array('name' => 'First course',
            'category' => $categoryone->id));
        $coursesubsubone = $this->getDataGenerator()->create_course(array('category' => $subsubcategoryone));
        $coursetwo = $this->getDataGenerator()->create_course(array('name' => 'First course',
            'category' => $categorytwo->id));

        // Test default user.
        $this->courseid = $courseone->id;
        $userto = $this->notify_evaluation_responsible_person();
        self::assertEquals($userto, $defaultuser);

        // Test subcategory user without parent user.
        $this->courseid = $coursesubsubone->id;
        self::assertEquals($defaultuser, $this->notify_evaluation_responsible_person());

        // Insert new record.
        $record = new stdClass();
        $record->course_category = $categoryone->id;
        $record->userid = $userone->id;
        $DB->insert_record('block_evasys_sync_categories', $record, false);

        // Test custom user.
        $this->courseid = $courseone->id;
        $userto = $this->notify_evaluation_responsible_person();
        self::assertEquals($userto, $userone);

        $this->courseid = $coursetwo->id;
        self::assertEquals($defaultuser, $this->notify_evaluation_responsible_person());

        // Test subcategory user with parent user.
        $this->courseid = $coursesubsubone->id;
        self::assertEquals($userone, $this->notify_evaluation_responsible_person());

        // Insert new record for subcategory.
        $record = new stdClass();
        $record->course_category = $subcategoryone->id;
        $record->userid = $usersubone->id;
        $DB->insert_record('block_evasys_sync_categories', $record, false);

        self::assertEquals($usersubone, $this->notify_evaluation_responsible_person());

        // Insert new record for subsubcategory.
        $record = new stdClass();
        $record->course_category = $subsubcategoryone->id;
        $record->userid = $usersubsubone->id;
        $DB->insert_record('block_evasys_sync_categories', $record, false);

        self::assertEquals($usersubsubone, $this->notify_evaluation_responsible_person());
    }

    /**
     * Part of evasys_synchronizer function
     * @throws \Exception when e-mail request fails
     */
    private function notify_evaluation_responsible_person() {
        global $USER, $DB;
        $course = get_course($this->courseid);

        $user = $DB->get_record('block_evasys_sync_categories', array('course_category' => $course->category));
        if (!$user) {
            // Loop through parents.
            $parents = \coursecat::get($course->category)->get_parents();
            for($i = count($parents) - 1; $i >= 0; $i--)
            {
                $user = $DB->get_record('block_evasys_sync_categories', array('course_category' => $parents[$i]));
                if($user) {
                    $userto = \core_user::get_user($user->userid);
                }
            }
            if(!$user) {
                $userto = \core_user::get_user(get_config('block_evasys_sync', 'default_evasys_moodleuser'));
            }
        } else {
            $userto = \core_user::get_user($user->userid);
        }

        if (!$userto) {
            throw new \Exception('Could not find the specified user to send an email to.');
        }

        return $userto;
    }
}
