@general

Feature: As a registered user I want to log in to the site using my credentials.

Background:
  Given I am on Login page
  
Scenario: User logins into system
  When I login with credentials:
	| user_email | user1@example.com |
	| user_password | secret |
  Then I should be redirected to User Timeline page