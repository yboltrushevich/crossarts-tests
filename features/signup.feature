@registration
Feature: Sign up
  In order to get access to protected sections of the site
  As a user
  I want to be able to sign up

  Scenario Outline: Signing up with different user type
    Given I am not logged in
    And I sign up with valid data as <user>
    When admin confirms my registration
    Then I can login as a user
    And I can configure my profile

  Examples:
    | user        |
    | artist      |
    | artist team |
    | consumer    |
