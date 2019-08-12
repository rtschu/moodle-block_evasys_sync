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
 * Class for loading/storing course-date pairs in the DB.
 *
 * @package block_evasys_sync
 * @copyright 2019 Robin Tschudi
 * @license http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */
namespace block_evasys_sync;
use core\persistent;

defined('MOODLE_INTERNAL') || die;

class course_evaluation_allocation extends persistent{
    const TABLE = 'block_evasys_sync_courseeval';

    protected static function define_properties() {
        // State decoding:
        // 0: not opened.
        // 1: opened.
        // 2: closed.
        // 3: email sent.
        // 4: manual weird shit.
        return array(
            'course' => array(
                'type' => PARAM_INT,
                'message' => new \lang_string('invalidcourse', 'block_evasys_sync')
            ),
            'startdate' => array(
                'type' => PARAM_INT,
                'message' => new \lang_string('invaliddate', 'block_evasys_sync')
            ),
            'enddate' => array(
                'type' => PARAM_INT,
                'message' => new \lang_string('invaliddate', 'block_evasys_sync')
            ),
            'state' => array(
                'type' => PARAM_INT,
                'default' => 0,
                'message' => new \lang_string('invalidstate', 'block_evasys_sync')
            )
        );
    }
}