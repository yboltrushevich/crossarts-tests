@media
Feature: User manages media content
  In order to publish my media
  As a user
  I want manage my media content

 Background:
   Given I logged in with "user1@example.com" and "secret"

  Scenario: creating a set
    When I create set
    Then I see set details page

  Scenario: creating a presentation
	When I create presentation
	Then I see presentation details page

  Scenario: create a set containing existing items from media library
    Given I have at least one media set in personal library
    When I create set with existing items from media library
    Then I see created set with selected items

  Scenario: upload media to existing set
    Given I have at least one media set in personal library
    When I upload media to existing set
    Then I see uploaded media in selected set
	
  Scenario: editing a set
    Given I have at least one media set in personal library
	When I change set data
	Then I see updated set details

  Scenario: deleting a set
	Given I have at least one media set in personal library
    When I delete set
    Then I see media library page without this set

  Scenario: copying set from media library to showcase
    Given I have at least one media set in personal library
	When I copy the set to user showcase
	Then I see the set on user showcase

  Scenario: create a presentation containing existing items from media library
	Given I have at least one media set in personal library
	When I create presentation with existing items from media library
	Then I see presentation details page

  Scenario: editing a presentation
    Given I have at least one presentation in personal library
    When I change presentation data
    Then I see updated presentation details

  Scenario: deleting a presentation
    Given I have at least one presentation in personal library
    When I delete presentation
    Then I see media library page without this presentation

  @debug
  Scenario: copying presentation from media library to showcase
    Given I have at least one presentation in personal library
    When I copy the presentation to user showcase
    Then I see the presentation on user showcase