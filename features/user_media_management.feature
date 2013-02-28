Feature: User manages media content
  In order to publish my media
  As a user
  I want manage my media content

 Background:
   Given I logged in with "user25@example.com" and "secret"

  @set
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