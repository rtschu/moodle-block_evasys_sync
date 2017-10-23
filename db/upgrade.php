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
 * This file keeps track of upgrades to the evasys_sync block
 *
 * Sometimes, changes between versions involve alterations to database
 * structures and other major things that may break installations. The upgrade
 * function in this file will attempt to perform all the necessary actions to
 * upgrade your older installation to the current version. If there's something
 * it cannot do itself, it will tell you what you need to do.  The commands in
 * here will all be database-neutral, using the functions defined in DLL libraries.
 *
 * @package   blocks_evasys_sync
 * @license   http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

defined('MOODLE_INTERNAL') || die();

/**
 * Execute evasys_sync upgrade from the given old version
 *
 * @param int $oldversion
 * @return bool
 */
function xmldb_block_evasys_sync_upgrade($oldversion) {
    global $DB;
    $dbman = $DB->get_manager();
    if ($oldversion < 2017100404) {

        // Define table evasys_sync_categories to be created.
        $table = new xmldb_table('block_evasys_sync_categories');

        // Adding fields to table evasys_sync_categories.
        $table->add_field('course_category', XMLDB_TYPE_INTEGER, '10', null, XMLDB_NOTNULL, null, null);
        $table->add_field('userid', XMLDB_TYPE_INTEGER, '10', null, XMLDB_NOTNULL, null, null);

        // Adding keys to table evasys_sync_categories.
        $table->add_key('primary', XMLDB_KEY_PRIMARY, array('course_category'));
        $table->add_key('course_category', XMLDB_KEY_FOREIGN, array('course_category'), 'course_categories', array('id'));

        // Conditionally launch create table for evasys_sync_categories.
        if (!$dbman->table_exists($table)) {
            $dbman->create_table($table);
        }

        // Evasys_sync savepoint reached.
        upgrade_block_savepoint(true, 2017100404, 'evasys_sync');
    }
   return true;
}
