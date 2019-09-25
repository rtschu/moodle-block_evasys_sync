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
$string['invitestudents'] = 'Evaluation beauftragen';
$string['checkstatus'] = 'Status der Evaluationen anzeigen';
$string['countparticipants'] = 'Anzahl Teilnehmer: ';
$string['surveystatus'] = 'Evaluationsstatus:';
$string['finishedforms'] = 'Ausgefüllt:';
$string['evacourseid'] = 'EvaSys-Kurs-ID:';
$string['evainternalid'] = 'EvaSys-interne ID:';
$string['evacoursename'] = 'Veranstaltungsname:';
$string['surveys'] = 'Evaluationen: ';
$string['nocourse'] = 'Kurs konnte zur Zeit nicht gefunden werden, bitte versuchen Sie es später erneut.';
$string['nosurveys'] = 'Zur Zeit sind keine Evaluationen verfügbar.';
$string['syncnotpossible'] = 'Auf Grund technischer Schwierigkeiten konnte die Teilnehmerliste nicht zu EvaSys exportiert werden. Bitte wenden Sie sich an den Support.';
$string['syncsucessful'] = 'Sync zu EvaSys war erfolgreich.';
$string['syncalreadyuptodate'] = 'Teilnehmerliste war bereits auf dem aktuellen Stand.';
$string['syncnostudents'] = 'Es gibt in diesem Kurs keine Teilnehmer, die evaluieren könnten.';
$string['taskname'] = 'EvaSys-Umfragen öffnen und schließen';
$string['begin'] = 'Beginn';
$string['end'] = 'Ende';
$string['direct_invite_checkbox'] = 'Evaluation sofort starten';
$string['reactivate_invite'] = 'Einladung erneut durchführen';
$string['warning_inconsistent_states'] = "Einige Umfragen sind geöffnet, aber alle Umfragen sollten geschlossen sein.";
$string['change_mapping'] = "Zugeordnete Veranstaltungen auswählen";
$string['semester'] = "Semester";

// Multi allocation strings.

$string['selection_success'] = "Die Kurse wurden erfolgreich zugeordnet";
$string['add_course_header'] = "Wählen Sie die LSF-Veranstaltungen, die gemeinsam mit diesem Learnweb-Kurs evaluiert werden sollen";
$string['coursename'] = "Kursname";
$string['associated'] = "zugeordnet";
$string['forbidden'] = "Die Aktion ist im aktuellen Status des Kurses nicht zulässig";
$string['maincoursepredefined'] = 'Vordefinierte Zuordnung.';
$string['maincoursepredefined_help'] = 'Dieser LSF-Kurs ist fest zugeordnet, da dies der entsprechende Learnweb-Kurs ist. Falls Sie dies für nicht korrekt halten, wenden Sie sich bitte an den Learnweb-Support.';

// Direct invite strings.

$string['planorstartevaluation'] = 'Evaluationszeitraum festlegen';
$string['startevaluationnow'] = 'Evaluation sofort beginnen';
$string['requestagain'] = 'Erneut einladen oder beauftragen';
$string['title_send_success'] = "Evaluation erfolgreich gestartet";
$string['content_send_success'] = 'Es wurden {$a->sent} von {$a->total} Einladungsmails versendet. <br />' .
                                  '{$a->queued} Evaluationsperioden wurden festgelegt.';
$string['title_send_failure'] = "Fehler beim Versand";
$string['send_error'] = "Es gab einen Fehler beim automatischen Versenden, bitte kontaktieren Sie Ihren Support, oder benutzen Sie den manuellen Versand von EvaSys";
$string['not_enough_dates'] = "Bitte geben Sie Daten für ALLE Umfragen an!";
$string['content_nostudents'] = "Dieser Kurs enthält keine Teilnehmer, die an der Evaluation teilnehmen könnten.";
$string['direct_already'] = "Sie haben die Evaluation bereits gestartet. <br />" .
    "Es wurden keine neuen Einladungen versendet";
$string['direct_title_info'] = "Einladungen bereits versandt";
$string['title_send_rejected'] = "Unzulässiges Datum";
$string['content_send_rejected'] = "Ein Datum wurde in die Vergangenheit geändert. <br />" .
    "Dies ist nicht zulässig! Es können einzelne Evaluationsperioden geändert worden sein.<br />";
$string['title_send_invalid'] = "Fehlerhafter Zeitraum";
$string['content_send_invalid'] = "Eine Evaluationsperiode beginnt nachdem sie endet! <br />" .
    "Alle anderen Evaluationsperioden wurden wie gewohnt geändert.";

// New invite strings.
$string['title_success'] = "Erfolgreich";
$string['content_success_invite'] = "Die Evaluation wurde erfolgreich gestartet";
$string['content_success_direct'] = "Die Evaluationsperiode wurde erfolgreich gesetzt";
$string['title_date_invalid'] = "Unzulässiges Datum";
$string['content_invalidstart'] = "Der Start ist in der Vergangenheit";
$string['content_invalidend'] = "Das Ende ist in der Vergangenheit";
$string['content_start_after_end'] = "Der Start ist nach dem Ende";
$string['title_wrong_mode'] = "Unzulässige Operation";
$string['content_wrong_mode'] = "Dieser Kurs ist nicht im angenommenen Modus. Bitte wenden Sie sich an das Support-Team.";

// Form strings.

$string['startplaceholder'] = "Startdatum für die Evaluation";
$string['endplaceholder'] = "Enddatum für die Evaluation";

// Information box strings.

$string['title_success']  = "Evaluation erfolgreich beauftragt";
$string['title_uptodate'] = "Evaluation bereits beauftragt";
$string['title_failure']  = "Evaluation nicht beauftragt";

$string['content_success'] = "Sie haben die Evaluation erfolgreich beantragt.<br />" .
                             "!!!DIE EVALUATION HAT NOCH NICHT BEGONNEN!!!<br />" .
                             "Sie müssen nichts weiter tun, ".
                             "Ihr*e Evaluationsbeauftragte*r wird nach den Richtlinien Ihres Fachbereichs weiter verfahren.";

$string['content_uptodate'] = "Ihr*e Evaluationsbeauftragte*r hat bereist einen Auftrag zum Durchführen der Evaluation von Ihnen erhalten.<br />" .
                              "Für Fragen zum Status Ihrer Evaluation kontaktieren Sie bitte Ihre*n Evaluationsbeauftragte*n.";

$string['content_failure'] = "Leider konnte die Evaluation nicht beauftragt werden.<br />" .
                             "Bitte wenden Sie sich an den Support.";

$string['confirm_box'] = "Verstanden";
$string['content_confirm_reactivate'] = "Diese Option wird die Startzeit erneut freigeben. Eine erneutes Setzen der Startzeit wird " .
                                " alle Evaluationen neu anstoßen, für die mindestens ein*e neue*r Teilnehmer*in vorhanden ist. <br />" .
                                "Sind Sie sicher, dass sie die Startzeit freigeben möchten?";

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
$string['settings_mode'] = 'Standardmodus für Kategorien';
$string['settings_moodleuser_select'] = 'Kurskategorien';
$string['settings_cc_select'] = 'Kurskategorie auswählen';
$string['settings_cc_user'] = 'Nutzer-ID des Empfängers für die gewählte Kurskategorie';
$string['submit'] = 'Speichern';
$string['hd_user_cat'] = 'Benutzer-Kategorie Zuweisung';
$string['addcat'] = 'Kategorie hinzufügen';
$string['delete_confirm'] = 'Sind Sie sicher, dass der Nutzer für diese Kurskategorie gelöscht werden soll?';
$string['auto_mode'] = 'Automatischer Modus';


// Settings - category table.
$string['category_name'] = 'Kurskategorie';
$string['responsible_user'] = 'Moodle-Benutzer ID';
$string['tablecaption'] = 'Benutzerdefinierter Mail-Empfänger nach Synchronisation';
$string['default'] = 'Standard';
$string['delete_category_user'] = 'Eintrag löschen';
$string['delete'] = 'Löschen';

// Persistance class.
$string['invalidcoursecat'] = 'Ungültige Kurskategorie';
$string['invalidmode'] = "Ungültiger Modus";
$string['invalidcourse'] = 'Ungültiger Kurs';
$string['invalidsurvey'] = "Ungültige Umfrage";
$string['invaliddate'] = "Ungültiges Datum";
$string['invalidstate'] = "Ungültiger Statuscode";

// Privacy API.
$string['privacy:metadata'] = 'Lade Studierende ein, an Erhebungen zur Qualität der Lehre mit EvaSys-Umfragen teilzunehmen.';
$string['privacy:metadata:username'] = 'Benutzernamen von Studierenden, welche in einem Kurs eingeschrieben sind (as E-Mail-Adresse dargestellt, um EvaSys-Erfordernisse zu erfüllen).';

// Events.
$string['eventevaluationperiod_set'] = 'Evaluationszeitraum wurde festgelegt';
$string['eventevaluation_opened'] = 'Evaluation wurde gestartet';
$string['eventevaluation_closed'] = 'Evaluation wurde beendet';
$string['eventevaluation_requested'] = 'Evaluation wurde angefragt';

// Months.
$string['January'] = 'Januar';
$string['February'] = 'Februar';
$string['March'] = 'März';
$string['April'] = 'April';
$string['May'] = 'Mai';
$string['June'] = 'Juni';
$string['July'] = 'Juli';
$string['August'] = 'August';
$string['September'] = 'September';
$string['October'] = 'Oktober';
$string['November'] = 'November';
$string['December'] = 'Dezember';

// From...to.
$string['evaluationperiod'] = 'Evaluationszeitraum:';
$string['startondate'] = 'Zeitraum planen von';
$string['endondate'] = 'bis';

// Notices.
$string['evalperiodsetnotice'] = 'Evaluationszeitraum gesetzt';
$string['emailsentnotice'] = 'Evaluation beauftragt';