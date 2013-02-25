@registration
Feature: Sign up
  In order to get access to protected sections of the site
  As a user
  I want to be able to sign up

  @artist
  Scenario: User signs up with valid data as artist
    Given I am not logged in
    When I sign up with valid data as artist
    And admin confirms my registration
    Then I can login as a user

  @artist_team
  Scenario: User signs up with valid data as artist team
    Given I am not logged in
    When I sign up with valid data as artist team
    And admin confirms my registration
    Then I can login as a user

  @consumer
  Scenario: User signs up with valid data as consumer
    Given I am not logged in
    When I sign up with valid data as consumer
    And admin confirms my registration
    Then I can login as a user

