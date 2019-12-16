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

    /**
     * @BeforeSuite
     */

    public static function prepare () {

    }

    /**
     * @AfterSuite
     */

    public static function cleandb () {
        \block_evasys_sync\tear_down();
        // \block_evasys_sync\evasys_api_testable::get_instance()->tear_down();
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
     * @Given The following evasys courses exist:
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
        } else {
            $record = new stdClass();
            $record->userid = 2;
            $record->course_category = $id;
            $record->category_mode = 0;
            $persistent = new \block_evasys_sync\user_cat_allocation(0, $record);
            $persistent->create();
        }
    }

    /**
     * @Given category :x is in automatic mode
     */

    public function category_is_in_automatic_mode ($id) {
        if ($cc = \block_evasys_sync\user_cat_allocation::get_record(array("course_category" => $id))) {
            $cc->set('category_mode', 1);
            $cc->update();
        } else {
            $record = new stdClass();
            $record->userid = 2;
            $record->course_category = $id;
            $record->category_mode = 1;
            $persistent = new \block_evasys_sync\user_cat_allocation(0, $record);
            $persistent->create();
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
     * @Then I should see a button named :name
     */
    public function i_should_see_a_button_named($name) {
        $this->find_button($name);
    }


}