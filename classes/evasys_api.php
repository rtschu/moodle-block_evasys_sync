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
/**
 * Created by PhpStorm.
 * User: robintschudi
 * Date: 08.11.19
 * Time: 15:56
 */

namespace block_evasys_sync;

use gradereport_singleview\local\screen\select;

defined('MOODLE_INTERNAL') || die();

class evasys_api {

    private $soapclient;
    private static $instance;

    private function __construct() {
        $this->soapclient = $this->init_soap_client();
    }

    public static function get_instance() {
        if (defined("BEHAT_SITE_RUNNING")) {
            return evasys_api_testable::get_instance();
        }
        if (!self::$instance) {
            self::$instance = new evasys_api();
        }
        return self::$instance;
    }

    public function get_course($evasyskennung) {
        $soapresult = $this->soapclient->GetCourse($evasyskennung, 'PUBLIC', true, false);
        return $soapresult;
    }

    public function send_invitation_to_participants_of_survey($surveyid) {
        $this->soapclient->SendInvitationToParticipants($surveyid);
    }

    public function insert_participants ($personlist, $evasyscourse) {
        $soapresult = $this->soapclient->InsertParticipants($personlist, $evasyscourse, 'PUBLIC', false);
        return $soapresult;
    }

    public function create_passwords ($evasysid, $pwcount) {
        $this->soapclient->GetPswdsBySurvey($evasysid, $pwcount, 1, true, false);
    }

    public function insert_close_task ($task) {
        return $this->soapclient->InsertCloseTask($task);
    }

    public function close_survey($surveyid) {
        return $this->soapclient->CloseSurvey($surveyid);
    }

    public function get_form($formid ) {
        $soapresult = $this->soapclient->GetForm($formid, 'INTERNAL', false);
        return $soapresult;
    }

    private function init_soap_client() {
        $soapclient = new \SoapClient(get_config('block_evasys_sync', 'evasys_wsdl_url'), [
            'trace' => 1,
            'exceptions' => 0,
            'location' => get_config('block_evasys_sync', 'evasys_soap_url')
        ]);

        $headerbody = new \SoapVar([
                                       new \SoapVar(get_config('block_evasys_sync', 'evasys_username'),
                                                    XSD_STRING, null, null, 'Login', null),
                                       new \SoapVar(get_config('block_evasys_sync', 'evasys_password'),
                                                    XSD_STRING, null, null, 'Password', null),
                                   ], SOAP_ENC_OBJECT);
        $header = new \SOAPHEADER('soap', 'Header', $headerbody);
        $soapclient->__setSoapHeaders($header);
        return $soapclient;
    }

}

