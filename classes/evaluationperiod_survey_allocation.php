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
 * Class for loading/storing user-category pairs in the DB.
 *
 * @package block_evasys_sync
 * @copyright 2017 Tamara Gunkel
 * @license http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

namespace block_evasys_sync;

defined('MOODLE_INTERNAL') || die;

use core\persistent;

/**
 * Class for loading/storing user-category pairs in the DB.
 *
 * @copyright 2017 Tamara Gunkel
 * @license http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */
class evaluationperiod_survey_allocation extends persistent {
    const TABLE = 'block_evasys_sync_surveys';
    /**
     * Return the definition of the properties of this model.
     *
     * @return array
     */
    protected static function define_properties() {
        return array(
            'course' => array(
                'type' => PARAM_INT,
                'message' => new \lang_string('invalidcourse', 'block_evasys_sync')
            ),
            'survey' => array(
                'type' => PARAM_INT,
                'message' => new \lang_string('invalidsurvey', 'block_evasys_sync')
            ),
            'startdate' => array(
                'type' => PARAM_INT,
                'message' => new \lang_string('invaliddate', 'block_evasys_sync')
            ),
            'enddate' => array(
                'type' => PARAM_INT,
                'message' => new \lang_string('invaliddate', 'block_evasys_sync')
            ),
        );
    }
}