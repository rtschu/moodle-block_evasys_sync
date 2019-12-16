@block @block_evasys_sync @block_evasys_sync_manual_nonstandard
Feature: Use the manual nonstandardtime version of the evasys block
  To use the block in the nonstandartime manual mode
  I have to be able to see it.

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
      | student1 | C1 | student |
    And I log in as "teacher1"
    And I am on "Course 1" course homepage
    And category 0 is in manual mode
    And category 0 is not in standardtime mode

  Scenario: I add the block for the first time and there is an IDnumber set.
    Given The following Evasys relations exist:
      | shortname | idnumber | semestertxt | veranstnr |
      | C1        | 1        | WS 2018/19  | 1001      |
    And The following evasys courses exist:
      | evasysid        | title  | studentcount |
      | 1001 WS 2018/19 | Info 1 | 150          |
    And The following Forms exist:
      | id | name  | title             |
      | 1  | AA253 | Umfrage zu Info 1 |
    And The following surveys exist:
      | course          | title     | formid | open | completed |
      | 1001 WS 2018/19 | Umfrage 1 | 1      | 1    | 25         |
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    And I press "Show status of surveys"
    And I should see a button named "Request evaluation"
