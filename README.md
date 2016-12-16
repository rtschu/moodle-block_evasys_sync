[![Build Status](https://travis-ci.org/learnweb/moodle-block_evasys_sync.svg?branch=master)]
(https://travis-ci.org/learnweb/moodle-block_evasys_sync)

# moodle-block_evasys_sync *(release_candidate)* 
:100: Anonyme Lehrevaluation mit EvaSys und Moodle

Entwickelt von: Max Inden, Dennis Grzyb, [Nina Herrmann](https://github.com/NinaHerrmann), [Tobias Reischmann](https://github.com/tobiasreischmann) und [Jan Dageförde](https://github.com/Dagefoerde) (WWU Münster).
 
## Zweck

Zur Durchführung einer fairen Online-Lehrevaluation durch den Teilnehmerkreis einer Veranstaltung wird die Liste der berechtigten Teilnehmer benötigt. Diese Liste kann mit Hilfe dieses Plugins aus laufenden Learnweb-Kursen generiert werden.
Dadurch können nur berechtigte Teilnehmer evaluieren und es wird sichergestellt, dass jeder höchstens einmal evaluiert.
 
*Die zur Evaluation verwendete Software EvaSys stellt sicher, dass jeder Teilnehmer nur genau einmal an einer Befragung teilnehmen kann (TAN). Weiterhin stellt die Software sicher, dass durch ausgefüllte Fragebögen **kein Rückschluss** auf einzelne Teilnehmer möglich ist; d.h. die TAN wird bloß für den Beginn des Fragebogens verwendet.*
 

## Voraussetzungen

* Prüfung der [Annahmen](#annahmen).
* Moodle 3.1
* EvaSys-Server mit konfiguriertem API-Benutzer.
* ID eines Moodle-Nutzers, an welchen Benachrichtigungen versandt werden, muss bekannt sein (ideal: Evaluationskoordinator/in der Einrichtung).

## Installation

1. Plugin nach `blocks/evasys_sync` kopieren.
2. Moodle öffnen.
3. Einstellungen für EvaSys-API-Endpunkt und -Benutzer festlegen. User-ID benennen, deren E-Mail-Adresse für den Versand von Benachrichtigungen verwendet wird.  

## Annahmen

Das Plugin wurde auf Basis der folgenden Annahmen entwickelt.
Falls diese Annahmen bei Ihnen nicht zutreffen, sind möglicherweise
 Veränderungen am Plugin notwendig. Bitte erstellen sie ein
 [GitHub-Issue](https://github.com/learnweb/moodle-block_evasys_sync/issues), 
 welches Ihre Anforderungen erläutert.
 Noch mehr freuen wir uns, wenn Sie zur Lösung Ihres Anliegens einen
 [Pull Request](https://github.com/learnweb/moodle-block_evasys_sync/pulls)
 vorbereiten, den wir gerne gegenlesen und ggf. einpflegen.

- [x] Zur Evaluation wird EvaSys verwendet.
- [x] Es gibt eine Person, die für die Evaluationskoordination an der Einrichtung zuständig ist.
- [x] Manuelle Interaktion: Diese Person ist dafür verantwortlich, in EvaSys die generierten Teilnehmerlisten je Kurs in TAN-Listen zu überführen und Einladungen zu erstellen.
- [x] Lehrende entscheiden, zu welchem Zeitpunkt die Teilnehmer ihres Kurses zur Umfrage hinzugefügt werden (Push-Prinzip; keine Automatik).
- [x] Moodle und EvaSys sind (zumindest oberflächlich) mit LSF integriert: 
    * Zur Synchronisation muss das courseid-Feld des Moodle-Kurses die sog. "publishid" des LSF enthalten.
    * EvaSys-Umfragen sind nach dem Schema "[Veranstaltungsnummer] [Semester]" nach der Nomenklatur des LSF benannt. *publishid ist **ungleich** mit Veranstaltungsnummer!*
    * Moodle hat jederzeit Zugriff auf einen LSF-View, um ad hoc die Zuordnung *publishid --> Veranstaltungsnummer* vornehmen zu können. Daher nutzt dieses Plugin [local_lsf_unification](https://github.com/learnweb/his_unification).
- [x] Der Moodle-Webserver kann den EvaSys-Webserver erreichen.

Die Liste der Annahmen ist möglicherweise nicht vollständig.
     