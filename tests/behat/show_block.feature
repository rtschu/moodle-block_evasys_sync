@block @block_evasys_sync @block_evasys_sync_basictests
Feature: Show the evasys block
  In order to use the evasys_block
  as a teacher
  I need to be able to show the evasys block

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

  Scenario: Add a block with no idnum
    Given I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    Then I should see "Change mapping"
    And I should not see "Name:"

  Scenario: Add a block with invalid idnum
    Given The course C1 has idnumber 1
    And I turn editing mode on
    And I add the "EvaSys Sync" block
    And I turn editing mode off
    Then I should not see "Change mapping"
    And I should not see "Name:"

  Scenario: Add a Standard normally linked block.
    Given The following Evasys relations exist:
    | shortname | idnumber | semestertxt | veranstnr |
    | C1        | 1        | WS 2018/19  | 1001      |
    And the following evasys courses exist:
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
    Then I should see "Name: Info 1"
    Then I should see "Number of participants:"
    Then I should see "150"
    Then I should see "Surveys:"
    Then I should see "Umfrage zu Info 1"
    Then I should see "Survey status:"
    Then I should see "open"
    Then I should see "Completed forms:"
    Then I should see "25"
    Then I should see "Change mapping"
    Then I should see "Evaluation period"
    Then I should see "Planned period from"
    Then I should see a button named "Request evaluation"
