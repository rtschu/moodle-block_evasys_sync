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
$string['settings'] = 'EvaSys Sync Block Einstellungen';
$string['settings_username'] = 'EvaSys-API-Nutzername';
$string['settings_password'] = 'EvaSys-API-Password';
$string['settings_soap_url'] = 'EvaSys SOAP URL';
$string['settings_wsdl_url'] = 'EvaSys WSDL URL';
$string['settings_moodleuser'] = 'Standard Nutzer-ID des Benachrichtigungsempfängers nach Sync';
$string['settings_moodleuser_select'] = 'Kurskategorien';
$string['settings_cc_select'] = 'Kurskategorie auswählen';
$string['settings_cc_user'] = 'Nutzer-ID des Empfängers für die gewählte Kurskategorie';
$string['submit'] = 'Speichern';
$string['addcat'] = 'Kategorie hinzufügen';
$string['delete_confirm'] = 'Sind Sie sicher, dass der Nutzer für diese Kurskategorie gelöscht werden soll?';


// Settings - category table
$string['category_name'] = 'Kurskategorie';
$string['responsible_user'] = 'Moodle-Benutzer';
$string['tablecaption'] = 'Benutzerdefinierter Mail-Empfänger nach Synchronisation';
$string['default'] = 'Standard';
$string['delete_category_user'] = 'Nutzer löschen';
$string['delete'] = 'Löschen';