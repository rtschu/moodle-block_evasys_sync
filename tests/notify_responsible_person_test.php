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

    /**
     * @runInSeparateProcess
     */
    public function test_create_image() {
        global $CFG;
        $this->resetAfterTest(true);

        $generator = $this->getDataGenerator();
        $categoryOne = $this->getDataGenerator()->create_category();
        $categoryTwo = $this->getDataGenerator()->create_category();

        $courseOne = $this->getDataGenerator()->create_course(array('name' => 'First course',
            'category' => $categoryOne->id));
        $courseTwo = $this->getDataGenerator()->create_course(array('name' => 'First course',
            'category' => $categoryTwo->id));
        $courseThree = $this->getDataGenerator()->create_course();

        $evasysOne = new \block_evasys_sync\evasys_synchronizer($courseOne->id);


    }
}
