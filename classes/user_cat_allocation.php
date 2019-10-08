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
class user_cat_allocation extends persistent {

    const TABLE = 'block_evasys_sync_categories';

    /**
     * Return the definition of the properties of this model.
     *
     * @return array
     */
    protected static function define_properties() {
        return array(
            'userid' => array(
                'type' => PARAM_INT,
                'message' => new \lang_string('invaliduserid', 'error')
            ),
            'course_category' => array(
                'type' => PARAM_INT,
                'message' => new \lang_string('invalidcoursecat', 'block_evasys_sync')
            ),
            'category_mode' => array(
                'type' => PARAM_INT,
                'message' => new \lang_string('invalidmode', 'block_evasys_sync')
            ),
            'standard_time_mode' => array (
                'type' => PARAM_INT,
                'message' => new \lang_string('invalid_standard_time_mode', 'block_evasys_sync')
            )
        );
    }

    /**
     * Validate the user ID.
     *
     * @param $value
     * @return bool|\lang_string
     */
    protected function validate_userid($value) {
        if (!\core_user::is_real_user($value, true)) {
            return new \lang_string('invaliduserid', 'error');
        }
        return true;
    }
}