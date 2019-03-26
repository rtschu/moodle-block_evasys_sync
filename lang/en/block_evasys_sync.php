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
$string['invitestudents'] = 'Request evaluation';
$string['checkstatus'] = 'Show status of surveys';
$string['countparticipants'] = 'Number of participants: ';
$string['surveystatus'] = 'Survey status:';
$string['finishedforms'] = 'Completed forms:';
$string['evacourseid'] = 'EvaSys course ID:';
$string['surveys'] = 'Surveys: ';
$string['nocourse'] = 'Problem finding course, please try again later.';
$string['nosurveys'] = 'Currently there are no surveys available.';
$string['syncnotpossible'] = 'Unfortunately, course participants could not be synchronized to EvaSys due to a technical problem. Please get in touch with the support contact.';
$string['syncsucessful'] = 'Sync to EvaSys was successful';
$string['syncalreadyuptodate'] = 'Users were already up to date';
$string['taskname'] = 'Open and close Evasys surveys';

// Direct invite strings.

$string['direct_invite'] = "Invite participants directly";
$string['content_confirm'] = "This will stat the evaluations immediately!<br />" .
    "Are you sure You want to send invites/reminders to all participants?";
$string['title_send_success'] = "Evaluation started";
$string['content_send_success'] = '{$a->sent} of {$a->total} emails have been send';
$string['send_error'] = "There was an error while trying to send emails. Please contact Your local support, or send the Emails manually via EvaSys";

// Form strings.

$string['startplaceholder'] = "Pick a startdate";
$string['endplaceholder'] = "Pick an enddate";


// Information box strings.

$string['title_success']  = "Successfully requested the evaluation";
$string['title_uptodate'] = "The evaluation has already been requested";
$string['title_failure']  = "The evaluation could not be requested";

$string['content_success'] = "Your evaluation coordinator has been instructed to start the evaluation.<br />" .
    "!!!THE EVALUATION HAS NOT STARTED YET!!! <br />" .
    "However you have done your part,".
    " your evaluation coordinator will process your request in compliance with the regulations enforced by your organization.";

$string['content_uptodate'] = "Your evaluation coordinator has already been instructed to start the evaluation. <br />" .
    "If you have questions regarding the status of the evaluation please contact your evaluation coordinator.";

$string['not_enough_dates'] = "Please provide dates for ALL Surveys!";
$string['title_send_failure'] = "Error while sending";

$string['content_failure'] = "Unfortunately we weren't able to request the start of the evaluation. <br />" .
    "For help please contact your local support team";

$string['title_send_invalid'] = "Invalid time period";
$string['content_send_invalid'] = "An evaluationperiod is set to start after it ends. <br />" .
    "All other evlautionperiods have been changed normally.";


$string['confirm_box'] = "OK";

$string['title_success']  = "Successfully requested the evaluation";
$string['title_uptodate'] = "The evaluation has already been requested";
$string['title_failure']  = "The evaluation could not be requested";

$string['content_success'] = "Your evaluation coordinator has been instructed to start the evaluation.<br />" .
    "!!!THE EVALUATION HAS NOT STARTED YET!!! <br />" .
    "However, you have done your part.".
    "The coordinator will process your request in accordance with the regulations of your organization.";

$string['content_uptodate'] = "Your evaluation coordinator has already been instructed to start the evaluation. <br />" .
    "If you have questions regarding the status of the evaluation please contact your evaluation coordinator.";

$string['confirm_box'] = "OK";
$string['direct_already'] = "You have already sent invitations to all students.".
                            "No new invitations have been send";

$string['direct_title_info'] = "Invitation already complete";
$string['title_send_rejected'] = "Invalid Date";
$string['content_send_rejected'] = "One or more dates have been set to a date in the past. <br />" .
    "This is not allowed. Some evaluationperiods may have been altered.<br />";

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
$string['settings_mode'] = 'Default mode for categories';
$string['settings_moodleuser_select'] = 'Course categories';
$string['settings_cc_select'] = 'Select course category';
$string['settings_cc_user'] = 'Recipient (moodle user id) for selected course category';
$string['submit'] = 'Save changes';
$string['hd_user_cat'] = 'User-Category Allocation';
$string['addcat'] = 'Add Category';
$string['delete_confirm'] = 'Are you sure you want to delete the user for this course category?';

// Settings - category table.
$string['category_name'] = 'Course Category';
$string['responsible_user'] = 'Moodle User ID';
$string['tablecaption'] = 'Custom mail recipients after sync';
$string['default'] = 'Default';
$string['delete_category_user'] = 'Delete Entry';
$string['delete'] = 'Delete';

// Persistance class.
$string['invalidcoursecat'] = 'Invalid course category';
$string['invalidmode'] = 'Invalid category mode';
$string['invalidcourse'] = "Invalid course";
$string['invalidsurvey'] = "Invalid survey";
$string['invaliddate'] = "Invalid date";


// Privacy API.
$string['privacy:metadata'] = 'Invite students to participate in course quality evaluations performed using an EvaSys installation.';
$string['privacy:metadata:username'] = 'Usernames of students enrolled in a course (disguised as e-mail addresses to satisfy EvaSys requirements).';
