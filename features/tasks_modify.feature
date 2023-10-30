Feature: Task modify
Background: 

  Background: task have been added to database
    Given the following tasks exist:
    | name       | description       | due_date   |
    | hw1        | bdd               | 2023-10-20 |
    | hw2        | tdd               | 2023-10-21 |
    | hw3        | dd                | 2023-10-21 |

  Scenario: Adding a task
    Given I am on the tasks page
    When I create a new task with name "hw1", description "bdd", and due date "2023-10-20"
    Then I should see "hw1" in the tasks list

  Scenario: Editing a task
    Given I have added a task with name "hw1", description "bdd", and due date "2023-10-20"
    And I am on the tasks page
    When I edit "hw1" to change its name to "hw3"
    Then I should see "hw3" in the tasks list

  Scenario: Deleting a task
    Given I have added a task with name "hw1", description "bdd", and due date "2023-10-20"
    And I am on the tasks page
    When I delete the task named "hw3"
    Then I should not see "hw3" in the tasks list

  Scenario: Viewing a task
    Given I am on the tasks page
    When I view the details of the task named "hw1"
    Then I should see details for "hw1"
