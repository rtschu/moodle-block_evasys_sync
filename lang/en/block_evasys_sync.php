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

$string['pluginname'] = 'EvaSys Sync Block';
$string['evasys_sync'] = 'EvaSys Sync';
$string['evasys_sync:addinstance'] = 'Add a new EvaSys Sync Block';
$string['invitestudents'] = 'Invite students to surveys';
$string['checkstatus'] = 'Show status of surveys';
$string['countparticipants'] = 'Number of participants: ';
$string['surveystatus'] = 'Survey status:';
$string['finishedforms'] = 'Completed forms:';
$string['evacourseid'] = 'EvaSys course ID:';
$string['surveys'] = 'Surveys: ';
$string['nocourse'] = 'Problem finding course, please try again later.';
$string['nosurveys'] = 'Currently there are no surveys available.';
$string['syncnotpossible'] = 'Course participants could not be synchronized to EvaSys due to a technical problem.';
$string['syncsucessful'] = 'Sync to EvaSys was successful';
$string['syncalreadyuptodate'] = 'Users were already up to date';

// Survey status.
$string['surveystatusopen'] = 'open';
$string['surveystatusclosed'] = 'closed';

// Capabilities.
$string['evasys_sync:mayevaluate'] = 'Evaluate a course using EvaSys';
$string['evasys_sync:synchronize'] = 'Export participants to EvaSys';

// Settings.
$string['settings'] = 'EvaSys Sync Block Settings';
$string['settings_username'] = 'EvaSys Username';
$string['settings_password'] = 'EvaSys Password';
$string['settings_soap_url'] = 'EvaSys SOAP URL';
$string['settings_wsdl_url'] = 'EvaSys WSDL URL';
$string['settings_moodleuser'] = 'Default user ID of mail recipient after sync';
$string['settings_moodleuser_select'] = 'Course categories';
$string['settings_cc_select'] = 'Select course category';
$string['settings_cc_user'] = 'Recipient (moodle user) for selected course category';
$string['submit'] = 'Save changes';
$string['addcat'] = 'Add Category';
$string['delete_confirm'] = 'Are you sure you want to delete the user for this course category?';

// Settings - category table.
$string['category_name'] = 'Course Category';
$string['responsible_user'] = 'Moodle user';
$string['tablecaption'] = 'Custom mail recipients after sync';
$string['default'] = 'Default';
$string['delete_category_user'] = 'Delete user';
$string['delete'] = 'Delete';