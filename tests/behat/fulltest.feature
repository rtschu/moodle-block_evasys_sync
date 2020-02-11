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
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And no courses are mapped to course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
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
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of idnumber being set to one or none
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 67 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 40 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of idnumber being set to one or none
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of idnumber being set to one or none
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 197 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 196 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 51 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 91 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 97 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 57 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 124 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 185 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 137 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 42 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 9 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 126 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 193 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 182 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 12 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 127 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 7 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 62 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 173 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 66 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 25 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 140 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 47 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 88 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 162 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 187 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 173 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 168 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 199 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 17 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 24 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are inconsistent modes I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 4 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 117 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 38 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 37 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 80 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 33 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 75 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 136 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 138 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 64 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 103 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 137 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 44 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 4 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 147 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 143 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 175 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 136 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 176 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 20 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 148 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 147 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 106 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 60 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 116 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 179 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 123 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 175 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 145 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 39 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 94 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 65 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 46 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are inconsistent modes I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 150 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 141 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 174 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 69 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluation has been requested"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 140 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 100 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 174 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 8 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Request evaluation"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 5 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 152 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of idnumber being set to one or none
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 53 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 110 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of idnumber being set to one or none
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of idnumber being set to one or none
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 70 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 82 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 1 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 38 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 104 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 88 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 169 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 140 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 180 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 119 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 101 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 21 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 65 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 41 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 65 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 41 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 76 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 62 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 83 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 143 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 42 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 5 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 105 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 97 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 103 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 78 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 4 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 148 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 66 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 128 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 9 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are inconsistent modes I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 11 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 127 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 89 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 60 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 130 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 10 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 22 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 22 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 99 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 159 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 10 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 152 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 158 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 106 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 59 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 168 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 92 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 184 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 162 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 88 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 194 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 184 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 98 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 188 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 41 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 118 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 11 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 163 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 5 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 145 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 1 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 2 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 130 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are inconsistent modes I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 35 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 200 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 166 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 116 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluation has been requested"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 200 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 21 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 194 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 169 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Request evaluation"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 175 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 100 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of idnumber being set to one or none
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 53 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 64 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of idnumber being set to one or none
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    This should be valid regardless of idnumber being set to one or none
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 174 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 177 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 148 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 139 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 141 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 85 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 114 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 173 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 120 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 12 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 159 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 44 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 8 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 4 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 105 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 115 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 171 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 26 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 54 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 191 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 73 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 95 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 197 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 127 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 71 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 18 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 112 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 11 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 175 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those 
    If there are inconsistent modes I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 139 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 58 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are inconsistent modes I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 43 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 198 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 151 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "This evaluation was already started in another mode"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 111 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 45 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 147 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 116 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 23 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 38 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 85 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 80 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 104 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 20 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 105 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 22 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 55 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 102 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 104 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 1 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 199 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 67 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 193 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 42 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 191 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 96 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 122 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 53 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 189 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 172 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 45 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 19 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 101 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 85 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are inconsistent modes I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 34 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 133 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 180 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 7 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluation has been requested"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 30 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 131 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 64 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 197 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Request evaluation"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 93 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 42 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are inconsistent modes I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    Then I should see "This evaluation was already started in another mode"
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 61 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 160 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 37 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 40 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 46 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 138 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 20 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 75 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 143 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 39 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 150 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 24 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 46 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 168 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 118 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 115 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 72 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 183 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 110 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 67 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 105 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 31 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 8 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 176 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 200 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 189 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 77 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 93 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 146 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 118 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Request evaluation"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 191 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 48 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 60 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 68 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 24 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 94 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 1 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 139 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 162 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 147 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 115 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 82 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 15 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 123 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 35 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 119 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 111 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 101 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 111 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 151 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 126 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 157 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 5 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 135 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 59 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 135 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 104 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 103 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 61 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 13 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 108 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 75 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Request evaluation"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 21 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 118 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is a standartimemode I should see the option to use it
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 160 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 16 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 137 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 103 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 16 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 48 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 14 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 62 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 23 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 102 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 62 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 99 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 144 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 59 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 177 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 180 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 115 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 10 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 42 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there are any mapped courses I should see those 
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 54 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 93 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 52 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 31 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 73 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 92 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 42 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 46 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 78 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 175 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 196 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Request evaluation"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, one or none
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 113 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 119 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "manual"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluation has been requested"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Offer standard period of time"
    
  Scenario: If there is a standartimemode I should see the option to use it
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in manual mode
    And category 0 is in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Request evaluation"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 123 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 95 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 160 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And the startselector should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 24 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And the startselector should be disabled
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 27 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And both selectors should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 69 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 33 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 23 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 65 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 11 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 199 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 77 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 71 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 101 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 61 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 156 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 180 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 173 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 97 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 48 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 163 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 197 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 22 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 72 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 82 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 97 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 162 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 183 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 171 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 35 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 168 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 188 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 72 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 150 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 178 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 74 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 165 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 147 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 6 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 185 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 147 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 55 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 182 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 170 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 138 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 125 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 83 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 83 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 141 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 84 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 102 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 182 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 24 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And the startselector should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 90 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 194 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And the startselector should be disabled
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 123 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 72 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 158 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 41 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And both selectors should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 175 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 189 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 104 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 150 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And the startselector should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And the startselector should be disabled
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And both selectors should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are no students I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And no students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course does not contain any students that can evaluate it."
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 44 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 63 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 80 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And the startselector should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 113 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And the startselector should be disabled
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 77 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And both selectors should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 45 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 70 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 63 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 116 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 18 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 33 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 157 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 166 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 98 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 172 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 126 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 143 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 9 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 35 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 87 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 83 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 178 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 131 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 42 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 104 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 118 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 37 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 132 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 56 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 46 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 176 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 19 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 4 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 18 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 169 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 77 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 18 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 162 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 191 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 47 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 120 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 113 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 178 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 153 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 165 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 55 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 141 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 116 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 54 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 9 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 173 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 2 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 108 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And the startselector should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 77 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 72 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And the startselector should be disabled
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 36 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 102 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 152 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 32 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And both selectors should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 118 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 27 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 43 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 135 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And the startselector should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And the startselector should be disabled
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And both selectors should be disabled
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are only tutors I should see a warning
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And only tutors enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    And I should see "This course contains only tutors"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 83 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 169 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 97 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And the startselector should be disabled
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 189 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And the startselector should be disabled
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 40 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And both selectors should be disabled
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 178 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    This should be valid regardless of idnumber being set to none or one
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 110 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 103 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 112 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 102 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 17 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 77 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 135 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 162 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 41 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 145 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 142 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 58 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 145 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 83 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 111 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 22 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those 
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 8 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 80 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 65 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 73 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 170 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And the startselector should be disabled
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those 
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 110 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 156 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 169 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 169 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 56 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 71 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 163 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 28 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 132 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 105 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And both selectors should be disabled
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 3 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 142 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 39 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 86 |
      | 2 WS 2018/19  | Survey 2 | 1 | 1 | 137 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there are any mapped courses I should see those 
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And there is no idnumber mapped to course C1
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 103 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 144 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an idnumber I should see this evasys-course
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And The following Evasys relations exist: 
      | shortname | idnumber | semestertxt | veranstnr |
      | C1 | 0 | WS 2018/19 | 0 |
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 1 | WS 2018/19 | 1 |
      | 2 | WS 2018/19 | 2 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
      | 2 WS 2018/19 | Evatestcourse 2 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 123 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 184 |
      | 2 WS 2018/19  | Survey 2 | 1 | 0 | 187 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 187 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 92 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 33 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 90 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 44 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 103 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And the startselector should be disabled
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 77 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 58 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And the startselector should be disabled
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 48 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 87 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 180 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 138 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And both selectors should be disabled
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 1 | 65 |
      | 1 WS 2018/19  | Survey 1 | 1 | 1 | 114 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are any mapped courses I should see those 
    This should be valid regardless of mapped courses being set to multi, none or one
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And the course with shortname C1 has the following lsfcourses mapped:
      | lsfcourse | semestertxt | veranstnr |
      | 0 | WS 2018/19 | 0 |
      | 1 | WS 2018/19 | 1 |
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And the following evasys courses exist:
      | evasysid | title | studentcount |
      | 0 WS 2018/19 | Evatestcourse 0 | 200 |
      | 1 WS 2018/19 | Evatestcourse 1 | 200 |
    And The following surveys exist: 
      | course | title  | formid | open | completed |
      | 0 WS 2018/19  | Survey 0 | 1 | 0 | 36 |
      | 1 WS 2018/19  | Survey 1 | 1 | 0 | 86 |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "notopened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Evaluationperiod has been set   "
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And the startselector should be disabled
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "opened"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And the startselector should be disabled
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    If there are surveys that don't match the internal state I should see a warning
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And both selectors should be disabled
    And I should see "There are some open surveys, but all surveys should be closed."
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And the internal state of course C1 is "closed"
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And both selectors should be disabled
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Set evaluation period"
    And I should not see "Offer standard period of time"
    
  Scenario: If there is no standardtimemode I should not see the option to use it
    This should be valid regardless of standardtime being set to 0 or 1
    If there is an invalid idnumber I should see a warning
    If there are invalid mappings I should see a warning
    Given category 0 is in auto mode
    And category 0 is not in standardtime mode
    And students enrolled in course C1
    And the idnumber for course C1 is invalid
    And only invalid mappings are present for course C1
    And The following Forms exist: 
      | id | name  | title |
      | 1 | AAAA1 | Testformnr. 1 |
    And there is no internal record of course C1
    And The following surveys exist: 
      | course | title  | formid | open | completed |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    Then I should see "The lsf-course linked to this course is invalid"
    Then I should see "One of the associated lsf-courses is invalid"
    And I should see "Set evaluation period"
    And I should see "Some of the surveys have been closed ahead of schedule!"
    And I should not see "Offer standard period of time"
    
