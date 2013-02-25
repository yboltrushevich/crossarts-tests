@debug
Feature: User manages media content
  In order to publish my media
  As a user
  I want manage my media content

  @set
  Scenario: creating a set
	Given I logged in with "user18@example.com" and "secret"
    When I create set
    Then I see set details page

  Scenario: creating a presentation
    Given I logged in with "user18@example.com" and "secret"
	When I create presentation
	Then I see presentation details page

  Scenario: create a set containing existing items from media library
    Given I logged in with "user18@example.com" and "secret"
    And I had at least one media set in personal library
    When I create set with existing items from media library
    Then I see set details page