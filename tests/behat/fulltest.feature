@block @block_evasys_sync @block_evasys_sync_fulltest
Feature: Tests all use-cases of the Evasys-block

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email |
      | teacher1 | Teacher | 1 | teacher1@example.com |
	  | student1 | Student | 1 | student1@example.com |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1 | 0 |
    And the following "course enrolments" exist:
      | user | course | role |
      | teacher1 | C1 | editingteacher |
    And I log in as "teacher1"
    And I am on "Course 1" course homepage

  Scenario: If there are no related evasys-courses I should not see any.
    Given category 1 is in auto mode
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
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
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
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "notopened"
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
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 103 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 146 |
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
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
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
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "notopened"
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
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
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
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
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
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are any mapped courses I should see those
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 48 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 32 |
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
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 3 |
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
    If there are any mapped courses I should see those
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 196 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 98 |
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
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
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
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 175 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 158 |
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
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 133 |
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
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 26 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 167 |
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
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 60 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 3 |
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
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "opened"
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
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "closed"
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
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 62 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 141 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 126 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 105 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 96 |
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
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 73 |
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
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
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
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And no courses are mapped to course C1
    And the internal state of course C1 is "notopened"
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
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
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
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 14 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 39 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 18 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 137 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And no courses are mapped to course C1
    And the internal state of course C1 is "notopened"
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
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
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
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
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
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
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
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "notopened"
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
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "notopened"
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
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
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
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "notopened"
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
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 27 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 170 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "notopened"
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
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 86 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 139 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 55 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 179 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 40 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 105 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 174 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 107 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 129 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 167 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 183 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 104 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 191 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 75 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 67 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 157 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 127 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 140 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 195 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 38 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 48 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And no courses are mapped to course C1
    And the internal state of course C1 is "notopened"
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
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 91 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 26 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 8 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 123 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And no courses are mapped to course C1
    And the internal state of course C1 is "notopened"
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
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "notopened"
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
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "notopened"
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
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
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
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "notopened"
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
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of idnumber being set to none or one
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
    And I should see "Evaluation has been requested"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of idnumber being set to none or one
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
    This should be valid regardless of idnumber being set to none or one
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 196 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 12 |
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
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 24 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 53 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 157 |
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
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 137 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 4 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 15 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 130 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 164 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 182 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 33 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 2 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 156 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And the submitbutton should be enabledAnd I should not see "Alter evaluationperiod for special courses"
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 198 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 118 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 191 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see a button named "Request evaluation"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are inconsistent modes I should see a warning
    Given category 1 is in auto mode
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
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are inconsistent modes I should see a warning
    Given category 1 is in manual mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And no courses are mapped to course C1
    And the internal state of course C1 is "notopened"
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
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
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
    And I should see "Evaluation has been requested"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
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
    This should be valid regardless of mapped courses being set to none, multi or one
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
    And the internal state of course C1 is "notopened"
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
    And I should see "Evaluation has been requested"
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

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
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
    And both selectors should be disabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
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
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
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
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 44 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 23 |
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
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 132 |
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
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 108 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 43 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 28 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 191 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 161 |
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
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 165 |
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
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
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
    And both selectors should be disabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And no students enrolled in course C1
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
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
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
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
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
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."

  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
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
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And only tutors enrolled in course C1
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
    And both selectors should be disabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And only tutors enrolled in course C1
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
    And I should see "This course contains only tutors"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And only tutors enrolled in course C1
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
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 102 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 153 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And only tutors enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "manual"
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
    And both selectors should be disabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 56 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 170 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And only tutors enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 185 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 193 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 160 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And only tutors enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 181 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And only tutors enrolled in course C1
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
    And both selectors should be disabled
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And only tutors enrolled in course C1
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
    And I should see "This course contains only tutors"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And only tutors enrolled in course C1
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
    And both selectors should be disabled
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And only tutors enrolled in course C1
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
    And I should see "This course contains only tutors"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And only tutors enrolled in course C1
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
    And I should see "This course contains only tutors"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And only tutors enrolled in course C1
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
    And I should see "This course contains only tutors"

  Scenario: If there is a standartimemode I should see the option to use it
    This should be valid regardless of idnumber being set to none or one
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
    And I should see "Evaluation has been requested"
    And I should see "Alter evaluationperiod for special courses"

  Scenario: If there is a standartimemode I should see the option to use it
    This should be valid regardless of idnumber being set to none or one
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
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
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
    And I should see "Alter evaluationperiod for special courses"

  Scenario: If there is a standartimemode I should see the option to use it
    If there are any mapped courses I should see those
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 124 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 87 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is a standartimemode I should see the option to use it
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 82 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 155 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 46 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is a standartimemode I should see the option to use it
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "manual"
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 38 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 93 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And the submitbutton should be enabledAnd I should see "Alter evaluationperiod for special courses"
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 56 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 104 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is a standartimemode I should see the option to use it
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 4 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is a standartimemode I should see the option to use it
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
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
    And I should see "Evaluation has been requested"
    And I should see "Alter evaluationperiod for special courses"

  Scenario: If there is a standartimemode I should see the option to use it
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
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
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in manual mode
    And category 1 is in standardtime mode with dates 1581043586 1582043586
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
    And I should see "Alter evaluationperiod for special courses"

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
    And I should see "Evaluation has been requested"
    And I should see "Alter evaluationperiod for special courses"

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
    And I should see a button named "Request evaluation"
    And I should see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 21 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 109 |
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
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 22 |
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
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 80 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 103 |
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
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 13 |
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
    If there are any mapped courses I should see those
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 99 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 156 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 26 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are any mapped courses I should see those
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 36 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 127 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 7 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 116 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 15 |
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
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 88 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 39 |
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
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 109 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 88 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 44 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 94 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 70 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 42 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 122 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 125 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course does not contain any students that can evaluate it."
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 108 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 130 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 126 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 185 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 75 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 95 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 91 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 43 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "opened"
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
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 106 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 41 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 165 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 176 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 78 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 108 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 139 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 54 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 163 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 28 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 37 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 119 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 121 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 39 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And only tutors enrolled in course C1
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 192 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "This course contains only tutors"
    And I should see "Name: Evatestcourse 0"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "notopened"
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
    And I should see "Evaluationperiod has been set"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "notopened"
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
    And I should see "Evaluationperiod has been set"
    And the submitbutton should be enabledAnd I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
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
    And the submitbutton should be enabledAnd I should not see "Alter evaluationperiod for special courses"

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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 83 |
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
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 4 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 43 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set"
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
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
    And I should see "Evaluationperiod has been set"
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 115 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 40 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set"
    And the submitbutton should be enabledAnd I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 107 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set"
    And the submitbutton should be enabledAnd I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 157 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 109 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 32 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 169 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 105 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And the submitbutton should be enabledAnd I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 66 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And the submitbutton should be enabledAnd I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 113 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 134 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "closed"
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
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 87 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 193 |
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
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 49 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 118 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 10 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 135 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"

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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 138 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 51 |
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
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of mapped courses being set to none, multi or one
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And no courses are mapped to course C1
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 68 |
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
    If there is an invalid idnumber I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And no courses are mapped to course C1
    And the internal state of course C1 is "notopened"
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
    And I should see "Evaluationperiod has been set"
    And I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And no courses are mapped to course C1
    And the internal state of course C1 is "notopened"
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
    And I should see "Evaluationperiod has been set"
    And the submitbutton should be enabledAnd I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    This should be valid regardless of mapped courses being set to none, multi or one
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
    And the submitbutton should be enabledAnd I should not see "Alter evaluationperiod for special courses"

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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 184 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 1 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 1 is in auto mode
    And category 1 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And the internal state of course C1 is "notopened"
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
    And I should see "Evaluationperiod has been set"
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
    And the internal state of course C1 is "notopened"
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
    And I should see "Evaluationperiod has been set"
    And the submitbutton should be enabledAnd I should not see "Alter evaluationperiod for special courses"

  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
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
    And the submitbutton should be enabledAnd I should not see "Alter evaluationperiod for special courses"

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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 61 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 158 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should see "Evaluationperiod has been set"
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 7 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 75 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should see "Evaluationperiod has been set"
    And the submitbutton should be enabledAnd I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 22 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 149 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And the startselector should be disabled
    And the submitbutton should be enabledAnd I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 132 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 182 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 99 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 187 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should see a button named "Set evaluation period"
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 62 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 58 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The hard linked evasys-course is invalid!"
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
    And I should see "Name: Evatestcourse 1"

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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 149 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see "Evaluationperiod has been set"
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 19 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see "Evaluationperiod has been set"
    And the submitbutton should be enabledAnd I should see a button named "Set evaluation period"
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
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following Forms exist:
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And The following surveys exist:
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 122 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And the startselector should be disabled
    And the submitbutton should be enabledAnd I should see "There are some closed surveys, but all surveys should be open."
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 62 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And both selectors should be disabled
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
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 142 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
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
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 13 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the dynamically mapped evasys-courses is invalid"
    And I should see a button named "Set evaluation period"
    And I should see "There are some closed surveys, but all surveys should be open."
    And I should not see "Alter evaluationperiod for special courses"
    And I should see "Name: Evatestcourse 0"
