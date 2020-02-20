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
 * Steps definitions related with the evasys_sync block.
 *
 * @package    block_evasys_sync
 * @category   test
 * @copyright  2019 Robin Tschudi
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

require_once(__DIR__ . '/../../../../lib/behat/behat_base.php');

use Behat\Gherkin\Node\TableNode as TableNode;
/**
 * evasys_sync-related steps definitions.
 *
 * @package    block_evasys_sync
 * @category   test
 * @copyright  2019 Robin Tschudi
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */
class behat_block_evasys_sync extends behat_base {

    private $evasysapi;
    private $generator;

    /**
     * @BeforeSuite
     */

    public static function prepare () {
    }

    /**
     * @BeforeScenario
     */
    public static function prepare_database() {
        \block_evasys_sync\clean_database();
    }

    /**
     * @AfterSuite
     */

    public static function cleandb () {
        \block_evasys_sync\tear_down();
        \block_evasys_sync\evasys_api_testable::get_instance()->tear_down();
    }

    /**
     * Take screenshot when step fails.
     * Works only with Selenium2Driver.
     * This little function makes it possible to see what behat is executing.
     *
     * @AfterStep
     */
    public function take_screenshot_after_failed_step (Behat\Behat\Hook\Scope\AfterStepScope $scope) {
        $logall = true;
        if (99 === $scope->getTestResult()->getResultCode() || $logall) {
            $img = $this->getSession()->getDriver()->getContent();
            file_put_contents("/var/www/public/moodle38/errorbackend.html", $img);
        }
    }

    public function __construct() {
        // The set_up call belongs into prepare. However prepare has no access to the $DB variable as its executed BEFORE
        // the config is included. Therefore it's in the constructor.
        require_once(__DIR__ . "/../../classes/lsf_api_mock_testable.php");
        \block_evasys_sync\set_up();
        require_once(__DIR__ . '/../../classes/evasys_api.php');
        $this->evasysapi = \block_evasys_sync\evasys_api_testable::get_instance();
        $this->generator = new \behat_data_generators();
    }

    private function get_courseid_by_shortname($shortname) {
        global $DB;
        return $DB->get_field("course", "id", array("shortname" => $shortname));
    }

    // Evasys setters.

    // idnumber = lsfid -> (semestertxt, veranstnr) = evasyskennung -> EvaSys Daten
    /**
     * @Given The following Evasys relations exist:
     */
    public function the_following_evasys_relations_exist(TableNode $table) {
        $hash = $table->getHash();
        foreach ($hash as $row) {
            $this->the_course_has_idnumber($row['shortname'], $row['idnumber']);
            $this->the_lsfcourse_with_id_has_semestertxt_and_veranstnr($row['idnumber'], $row['semestertxt'], $row['veranstnr']);
        }
    }

    /**
     * @Given /the following evasys courses exist:/
     */
    public function the_following_evasys_courses_exist(TableNode $table) {
        $evasysapi = $this->evasysapi;
        $evasysapi->clear_courses();
        $hash = $table->getHash();
        foreach ($hash as $row) {
            $evasysapi->set_course($row['evasysid'], $row['title'], $row['studentcount']);
        }
    }

    /**
     * @Given The following surveys exist:
     */
    public function the_following_surveys_exist(TableNode $table) {
        $evasysapi = $this->evasysapi;
        $evasysapi->clear_surveys();
        $hash = $table->getHash();
        foreach ($hash as $row) {
            $evasysapi->add_survey($row['course'], 1, $row['title'], $row['formid'], $row['open'], $row['completed'], 0);
        }
    }

    /**
     * @Given The following Forms exist:
     */
    public function the_following_forms_exist(TableNode $table) {
        $hash = $table->getHash();
        $evasysapi = $this->evasysapi;
        $evasysapi->clear_forms();
        foreach ($hash as $row) {
            $evasysapi->set_form($row['id'], $row['name'], $row['title']);
        }
    }

    // LSF setters
    /**
     * Sets a courses Idnumber
     *
     * @Given The course :coursename has idnumber :idnum
     * @param int $courseid
     * @param int $idnum
     */
    public function the_course_has_idnumber($name, $idnum) {
        global $DB;
        $DB->execute("UPDATE {course} SET idnumber=$idnum WHERE shortname='$name'");
    }

    /** Sets semestertxt and veranstnr for a given lsfcourse
     * @param $id
     * @param $semestertxt
     * @param $veranstnr
     * @Given The lsfcourse with id :id has semestertxt :semestertxt and veranstnr :veranstnr
     */

    public function the_lsfcourse_with_id_has_semestertxt_and_veranstnr($id, $semestertxt, $veranstnr) {
        \block_evasys_sync\set_course_to_veranstid($id, $veranstnr, $semestertxt);
    }



    // Categorymode manipulation
    /**
     * @Given category :x is in manual mode
     */

    public function category_is_in_manual_mode ($id) {
        if ($cc = \block_evasys_sync\user_cat_allocation::get_record(array("course_category" => $id))) {
            $cc->set('category_mode', 0);
            $cc->update();
            $cc->save();
        } else {
            $record = new stdClass();
            $record->userid = 2;
            $record->course_category = $id;
            $record->category_mode = 0;
            $persistent = new \block_evasys_sync\user_cat_allocation(0, $record);
            $persistent->create();
            $persistent->save();
        }
    }

    /**
     * @Given category :x is in automatic mode
     */

    public function category_is_in_automatic_mode ($id) {
        if ($cc = \block_evasys_sync\user_cat_allocation::get_record(array("course_category" => $id))) {
            $cc->set('category_mode', 1);
            $cc->update();
            $cc->save();
        } else {
            $record = new stdClass();
            $record->userid = 1;
            $record->course_category = strval($id);
            $record->category_mode = 1;
            $persistent = new \block_evasys_sync\user_cat_allocation(0, $record);
            $persistent->create();
            $persistent->save();
        }
    }

    /**
     * @Given category :x is in standardtime mode with dates :start :end
     */

    public function category_is_in_standardtime_mode ($cat, $start, $end) {
        global $DB;
        $sql = 'UPDATE {block_evasys_sync_categories} SET standard_time_start = ?, standard_time_end = ? ' . 'WHERE course_category = ?';
        print($sql);
        $DB->execute($sql, array($start, $end, $cat));
    }

    /**
     * @Given category :x is not in standardtime mode
     */

    public function category_is_not_in_nonstandard_mode ($cat) {
        $this->category_is_in_standardtime_mode($cat, null, null);
    }

    /**
     * @Given there is no internal record of course :shortname
     */
    public function and_there_is_no_internal_record_of_course ($shortname) {
        global $DB;
        $id = $this->get_courseid_by_shortname($shortname);
        $DB->execute("DELETE FROM {block_evasys_sync_courseeval} WHERE course = ?", array($id));
    }

    /**
     * @Given the internal state of course :shortname is :mode
     */
    public function the_internal_state_of_course_is($shortname, $mode) {
        global $DB;
        $id = $this->get_courseid_by_shortname($shortname);
        $record = \block_evasys_sync\course_evaluation_allocation::get_record_by_course($id, false);
        if (!$record) {
            $record = new \block_evasys_sync\course_evaluation_allocation(0);
            $record->set('course', $id);
        }
        if ($mode == "manual") {
            $record->set('state', \block_evasys_sync\course_evaluation_allocation::STATE_MANUAL);
        } else if ($mode == "notopened") {
            $record->set('state', \block_evasys_sync\course_evaluation_allocation::STATE_AUTO_NOTOPENED);
        } else if ($mode == "opened") {
            $record->set('state', \block_evasys_sync\course_evaluation_allocation::STATE_AUTO_OPENED);
        } else if ($mode == "closed") {
            $record->set('state', \block_evasys_sync\course_evaluation_allocation::STATE_AUTO_CLOSED);
        } else {
            throw new \Exception("Didnt't recognize state");
        }
        $record->set('startdate', 1595714400);
        $record->set('enddate', 1595800800);
        $record->save();
    }

    /**
     * @Given only invalid mappings are present for course :shortname
     */
    public function only_invalid_mappings_are_present_for_course ($shortname) {
        $id = $this->get_courseid_by_shortname($shortname);
        $record = \block_evasys_sync\course_evasys_courses_allocation::get_record_by_course($id, false);
        if (!$record) {
            $record = new \block_evasys_sync\course_evasys_courses_allocation(0);
        }
        $record->set("course", $id);
        $record->set("evasyscourses", "-99#-100#-101");
        $record->save();
    }

    /**
     * @Given /^the course with shortname ([^"]*) has the following lsfcourses mapped:$/
     */
    public function the_course_with_shortname_has_the_following_lsfcourses_mapped ($shortname, TableNode $table) {
        $hash = $table->getHash();
        $lsfcourses = array();
        foreach ($hash as $row) {
            array_push($lsfcourses, $row['lsfcourse']);
            $this->the_lsfcourse_with_id_has_semestertxt_and_veranstnr($row['lsfcourse'], $row['semestertxt'], $row['veranstnr']);
        }

        $id = $this->get_courseid_by_shortname($shortname);
        $record = \block_evasys_sync\course_evasys_courses_allocation::get_record_by_course($id, false);
        if (!$record) {
            $record = new \block_evasys_sync\course_evasys_courses_allocation(0);
        }
        $record->set("course", $id);
        $record->set("evasyscourses", implode("#", $lsfcourses));
        $record->save();
    }

    /**
     * @Given no courses are mapped to course :shortname
     */
    public function no_courses_are_mapped_to_course($shortname) {
        global $DB;
        $courseid = $this->get_courseid_by_shortname($shortname);
        $pid = $DB->get_field('block_evasys_sync_courses', 'id', array('course' => $courseid));
        if (!$pid) {
            return;
        }
        $persistent = new \block_evasys_sync\course_evasys_courses_allocation($pid);
        $persistent->delete();
    }

    /**
     * @Given no students enrolled in course :course
     */
    public function no_students_enrolled_in_course($shortname) {
        // nothing to be done. But sure reads better.
    }

    /**
     * @Given only tutors enrolled in course :shortname
     */
    public function only_tutors_enrolled_in_course($shortname) {
        throw new \Behat\Behat\Tester\Exception\PendingException("TBD");
    }

    /**
     * @Given students enrolled in course :shortname
     */
    public function students_enrolled_in_course($shortname) {
        $head = array("user", "course", "role");
        $teacher = array("teacher1", $shortname, "editingteacher");
        $student = array("student1", $shortname, "student");
        $node = new \Behat\Gherkin\Node\TableNode(array($head, $teacher, $student));
        $this->generator->the_following_entities_exist("course enrolments", $node);
    }

    /**
     * @Given the idnumber for course :course is invalid
     */
    public function the_idnumber_for_course_is_invalid($shortname) {
        $this->the_course_has_idnumber($shortname, -99);
    }

    /**
     * @Given there is no idnumber mapped to course :shortname
     */
    public function there_is_no_idnumber_mapped($shortname) {
        // nothing to be done. But sure reads better.
    }

    /**
     * @Given course :arg1 has the following courses mapped:
     */
    public function course_has_the_following_courses_mapped ($shortname, TableNode $node) {
        global $DB;
        $courseid = $DB->get_field('course', 'id', array('shortname' => $shortname));
        $pid = $DB->get_field('block_evasys_sync_courses', 'id', array('course' => $courseid));
        if (!$pid) {
            $persistent = new \block_evasys_sync\course_evasys_courses_allocation(0);
        } else {
            $persistent = new \block_evasys_sync\course_evasys_courses_allocation($pid);
        }
        $hash = $node->getHash();
        $mapping = array();
        foreach ($hash as $row) {
            array_push($mapping, $row[courseid]);
        }
        $magicstring = implode("#", $mapping);
        // If the mapping is empty, remove it.
        if (empty($magicstring) && $persistent->get('id') != 0) {
            $persistent->delete();
        }
        // Only save the mapping, if the mapping string is not empty.
        if (!empty($magicstring)) {
            $persistent->set('course', $courseid);
            $persistent->set('evasyscourses', $magicstring);
            $persistent->save();
        }
    }

    /**
     * @Then I should see a button named :name
     */
    public function i_should_see_a_button_named($name) {
        $this->find_button($name);
    }

    private function get_max_idnumber () {
        global $DB;
        $max = $DB->get_records_sql("SELECT 'max' AS dummy, max(idnumber) AS max FROM {course}")['max']->max;
        return $max;
    }

    /**
     * @Given category :category is in auto mode
     */
    public function category_is_in_auto_mode ($id) {
        $this->category_is_in_automatic_mode($id);
    }

    /**
     * @Given the startselector should be disabled
     */
    public function the_startselector_should_be_disabled () {
        $startday = $this->find_field("day_start");
        if (is_null($startday->getAttribute('disabled'))) {
            throw new SelectorNotDisabledException();
        }
    }

    /**
     * @Given both selectors should be disabled
     */
    public function both_selectors_should_be_disabled () {
        $startday = $this->find_field("day_start");
        $endday = $this->find_field("day_end");
        if (is_null($startday->getAttribute('disabled')) or is_null($endday->getAttribute('disabled'))) {
            throw new SelectorNotDisabledException();
        }
    }

    /**
     * @Given the submitbutton should be enabled
     */
    public function the_submitbutton_should_be_enabled () {
        $button = $this->find_button("evasyssubmitbutton");
        if (! is_null($button->getAttribute('disabled'))) {
            throw new SubmitButtonDisabledException();
        }
    }


}