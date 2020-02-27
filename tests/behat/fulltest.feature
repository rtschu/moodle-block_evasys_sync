@block @block_evasys_sync @block_evasys_sync_fulltest
Feature: Tests all use-cases of the Evasys-block

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher | 1 | teacher1@example.com |
      | student1 | Student | 1 | student1@example.com |
      | tutor1   | Tutor   | 1 | tutor1@example.com | 
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1 | 0 |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |
    And I log in as "teacher1"
    And I am on "Course 1" course homepage

  Scenario: If there are no related evasys-courses I should not see any.
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And no courses are mapped to course C1
    And there is no internal record of course C1
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    Then I should see "Change mapping"
    And I should not see "Name:"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of idnumber being set to one or none
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 127 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of idnumber being set to one or none
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 55 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 20 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of idnumber being set to one or none
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 190 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "closed"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 35 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are any mapped courses I should see those
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 150 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 107 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 19 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are any mapped courses I should see those
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 129 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 96 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 118 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 127 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 193 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 103 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 166 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 115 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 59 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 102 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 17 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 32 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 169 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 88 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 127 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 1 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 182 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 97 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 179 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And no courses are mapped to course C1
    And the internal state of course C1 is "closed"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And no courses are mapped to course C1
    And there is no internal record of course C1
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 5 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "manual"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "closed"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "manual"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "closed"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 142 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 2 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of idnumber being set to one or none
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 17 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of idnumber being set to one or none
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 78 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "manual"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 32 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 111 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 168 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 144 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 158 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 118 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 58 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And the submitbutton should be enabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 159 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 105 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And the submitbutton should be enabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 44 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 122 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 43 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 53 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 199 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 50 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 18 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the submitbutton should be enabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 160 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 63 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the submitbutton should be enabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 10 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 135 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 135 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 51 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 85 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And no courses are mapped to course C1
    And the internal state of course C1 is "manual"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And no courses are mapped to course C1
    And there is no internal record of course C1
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And no courses are mapped to course C1
    And there is no internal record of course C1
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "manual"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "closed"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "manual"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 180 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should see "Evaluation has been requested"
    And the submitbutton should be enabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 129 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And no courses are mapped to course C1
    And the internal state of course C1 is "closed"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 31 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 19 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And the submitbutton should be enabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 125 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 177 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see "Evaluation has been requested"
    And the submitbutton should be enabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 6 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 184 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "closed"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 190 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And the submitbutton should be enabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 142 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of idnumber being set to one or none
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 178 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of idnumber being set to one or none
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 65 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 10 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 183 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 149 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 21 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 6 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 173 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 162 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 182 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "manual"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is a standartimemode I should see the option to use it
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "manual"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see "Alter evaluationperiod for special courses"

  Scenario: If there is a standartimemode I should see the option to use it
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of idnumber being set to one or none
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 164 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 197 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And the submitbutton should be enabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 39 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 179 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And the submitbutton should be enabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 75 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 151 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 186 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 5 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 35 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 184 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is a standartimemode I should see the option to use it
    If there is an invalid idnumber I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And no courses are mapped to course C1
    And the internal state of course C1 is "manual"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should see "Alter evaluationperiod for special courses"

  Scenario: If there is a standartimemode I should see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 116 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "manual"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see "Alter evaluationperiod for special courses"

  Scenario: If there is a standartimemode I should see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"

  Scenario: If there is a standartimemode I should see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 39 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should see "Evaluation has been requested"
    And the submitbutton should be enabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 19 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 176 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see "Evaluation has been requested"
    And the submitbutton should be enabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 80 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 87 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And the startselector should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "opened"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And the startselector should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 88 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 59 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 168 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 189 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 154 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 160 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 60 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 83 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 79 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are any mapped courses I should see those
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 175 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 72 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 193 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are any mapped courses I should see those
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 59 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 153 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 15 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 184 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 91 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 31 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 51 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 116 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 140 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And no courses are mapped to course C1
    And the internal state of course C1 is "opened"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And the startselector should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 116 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And the startselector should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And no courses are mapped to course C1
    And there is no internal record of course C1
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "opened"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And the startselector should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 123 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 186 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 34 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And the startselector should be disabled
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 186 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 141 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 115 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 138 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 117 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 23 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And the startselector should be disabled
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 50 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 52 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of number of students being set to none or onlytutors
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 154 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "opened"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And the startselector should be disabled
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 112 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set"
    And the submitbutton should be enabled
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 41 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 96 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set"
    And the submitbutton should be enabled
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 153 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set"
    And the submitbutton should be enabled
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 105 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 125 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set"
    And the submitbutton should be enabled
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 139 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And the submitbutton should be enabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 20 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 194 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And the submitbutton should be enabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 171 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And the submitbutton should be enabled
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 172 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 165 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And the submitbutton should be enabled
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 37 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 183 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 171 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 54 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the submitbutton should be enabled
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 32 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 170 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the submitbutton should be enabled
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 64 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those
    This should be valid regardless of mapped courses being set to one, none or multi
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 96 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 112 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And no courses are mapped to course C1
    And the internal state of course C1 is "opened"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And the startselector should be disabled
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "opened"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And the startselector should be disabled
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "closed"
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 160 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should see "Evaluationperiod has been set"
    And the submitbutton should be enabled
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 181 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should see "Evaluationperiod has been set"
    And the submitbutton should be enabled
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 97 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And the startselector should be disabled
    And the submitbutton should be enabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 169 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And the startselector should be disabled
    And the submitbutton should be enabled
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 101 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 57 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And the submitbutton should be enabled
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 167 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 23 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see "Evaluationperiod has been set"
    And the submitbutton should be enabled
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 22 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see "Evaluationperiod has been set"
    And the submitbutton should be enabled
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 58 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And the startselector should be disabled
    And the submitbutton should be enabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 183 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And the startselector should be disabled
    And the submitbutton should be enabled
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 9 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 113 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And the submitbutton should be enabled
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 30 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
