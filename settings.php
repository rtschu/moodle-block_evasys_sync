<?php
// This file is part of the Moodle plugin block_evasys_sync
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


defined('MOODLE_INTERNAL') || die;

if ($ADMIN->fulltree) {
    // Username.
    $name = 'block_evasys_sync/evasys_username';
    $title = get_string('settings_username', 'block_evasys_sync');
    $description = get_string('settings_usernamedesc', 'block_evasys_sync');
    $settings->add(new admin_setting_configtext($name, $title, $description, ''));

    // Password.
    $name = 'block_evasys_sync/evasys_password';
    $title = get_string('settings_password', 'block_evasys_sync');
    $description = get_string('settings_passworddesc', 'block_evasys_sync');
    $settings->add(new admin_setting_configpasswordunmask($name, $title, $description, ''));

    // SOAP URL.
    $name = 'block_evasys_sync/evasys_soap_url';
    $title = get_string('settings_soap_url', 'block_evasys_sync');
    $description = get_string('settings_soap_urldesc', 'block_evasys_sync');
    $settings->add(new admin_setting_configtext($name, $title, $description, ''));

    // WSDL URL.
    $name = 'block_evasys_sync/evasys_wsdl_url';
    $title = get_string('settings_wsdl_url', 'block_evasys_sync');
    $description = get_string('settings_wsdl_urldesc', 'block_evasys_sync');
    $settings->add(new admin_setting_configtext($name, $title, $description, ''));

    // Learnweb user for notifications.
    $name = 'block_evasys_sync/evasys_moodleuser';
    $title = get_string('settings_moodleuser', 'block_evasys_sync');
    $description = get_string('settings_moodleuserdesc', 'block_evasys_sync');
    $settings->add(new admin_setting_configtext($name, $title, $description, 25989, PARAM_INT));
}