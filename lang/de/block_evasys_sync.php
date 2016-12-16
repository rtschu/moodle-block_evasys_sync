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

$string['pluginname'] = 'EvaSys-Export-Block';
$string['evasys_sync'] = 'EvaSys-Export';
$string['evasys_sync:addinstance'] = 'EvaSys-Export-Block hinzufügen';
$string['invitestudents'] = 'Teilnehmer zu Evaluationen einladen';
$string['checkstatus'] = 'Status der Evaluationen anzeigen';
$string['countparticipants'] = 'Anzahl Teilnehmer: ';
$string['surveystatus'] = 'Evaluationsstatus:';
$string['finishedforms'] = 'Ausgefüllt:';
$string['evacourseid'] = 'EvaSys-Kurs-ID:';
$string['surveys'] = 'Evaluationen: ';
$string['nocourse'] = 'Kurs konnte zur Zeit nicht gefunden werden, bitte versuchen Sie es später erneut.';
$string['nosurveys'] = 'Zur Zeit sind keine Evaluationen verfügbar.';
$string['syncnotpossible'] = 'Auf Grund technischer Schwierigkeiten konnte die Teilnehmerliste nicht zu EvaSys exportiert werden.';
$string['syncsucessful'] = 'Sync zu EvaSys war erfolgreich.';
$string['syncalreadyuptodate'] = 'Teilnehmerliste war bereits auf dem aktuellen Stand.';

// Survey status.
$string['surveystatusopen'] = 'offen';
$string['surveystatusclosed'] = 'geschlossen';

// Capabilities.
$string['evasys_sync:mayevaluate'] = 'An Kursevaluation teilnehmen';
$string['evasys_sync:synchronize'] = 'Teilnehmer zu EvaSys synchronisieren';

// Settings.
$string['settings_username'] = 'EvaSys-API-Nutzername';
$string['settings_usernamedesc'] = 'Nutzername zur Anmeldung an der EvaSys-API';
$string['settings_password'] = 'EvaSys-API-Password';
$string['settings_passworddesc'] = 'Passwort zur Anmeldung an der EvaSys-API';
$string['settings_soap_url'] = 'EvaSys SOAP URL';
$string['settings_soap_urldesc'] = 'URL des EvaSys-SOAP-Webservices';
$string['settings_wsdl_url'] = 'EvaSys WSDL URL';
$string['settings_wsdl_urldesc'] = 'URL der WSDL-Datei des EvaSys-Webservices';
$string['settings_moodleuser'] = 'Nutzer-ID des Benachrichtigungsempfängers nach Sync';
$string['settings_moodleuserdesc'] = 'Die ID des Moodle-Benutzers, an welchen nach erfolgter Synchronisation informative Mails versendet werden.';