@debug
Feature: User manages media content
  In order to publish my media
  As a user
  I want manage my media content
  
  Scenario: creating a set
	Given I logged in with "user18@example.com" and "secret"
    When I create set
    Then I see set details page
