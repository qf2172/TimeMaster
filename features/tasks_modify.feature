Feature: Task modify
Background: 

  Background: task have been added to database
    Given the following tasks exist:
    | name       | description       | due_date   | difficulty| estimate  | start_time              |
    | hw1        | bdd               | 2023-11-16 |    medium | 10        | 2023-11-15 13:00:00 UTC |
    | hw2        | tdd               | 2023-11-23 |    urgent | 5         | 2023-11-14 14:00:00 UTC |
    | hw3        | hw3               | 2023-11-18 |    low    | 1         | 2023-11-21 14:00:00 UTC |

  Scenario: Adding a task
    Given I am on the tasks page
    When I create a new task with name "hw1", description "bdd", due date "2023-11-16", and estimate "10"
    Then I should see "hw1" in the tasks list

  Scenario: Editing a task
    Given I have added a task with name "hw1", description "bdd", due date "2023-11-16", and estimate "10"
    And I am on the tasks page
    When I edit "hw1" to change its name to "hw3"
    Then I should see "hw3" in the tasks list

  Scenario: Deleting a task
    Given I have added a task with name "hw1", description "bdd", due date "2023-11-16", and estimate "10"
    And I am on the tasks page
    When I delete the task named "hw3"
    Then I should not see "hw3" in the tasks list

  Scenario: Viewing a task
    Given I am on the tasks page
    When I view the details of the task named "hw1"
    Then I should see details for "hw1"

  Scenario: sort
    Given I am on the tasks page  
    When I click the "Due Date" 
    Then I should see "hw1" before "hw3"
    Then I should see "hw3" before "hw2"

  Scenario:Create validation error
    Given I am on the new task page
    When I submit invalid task information
    Then I should see an error message "Name"
    And I should be on the new task page again

  Scenario:Update validation error
    Given I am on the edit task page for task with id "1"
    When I submit invalid information for the task
    Then I should see an error message "Description"
    And I should be on the edit task page for task with id "1"
  