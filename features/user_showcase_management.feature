@showcase
Feature: User manages showcase content
  In order to publish my content
  As a user
  I want manage my showcase content

  Background:
    Given I logged in with "user1@example.com" and "secret"

  Scenario: creating a showcase set
    When I create showcase set
    Then I see showcase set details page

  Scenario: create a showcase set containing existing items from media library
    Given I have at least one media set in personal library
    When I create showcase set with existing items from media library
    Then I see created showcase set with selected items

  Scenario: upload media to existing showcase set
    Given I have at least one set in showcase
    When I upload media to existing showcase set
    Then I see uploaded media in selected showcase set