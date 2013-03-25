@general

Feature: As a registered user I want to log in to the site using my credentials.

Background:
  Given I am on Login page
  
Scenario: User logins into system
  When I logged in with "user1@example.com" and "secret"
  Then I should be redirected to Home page
