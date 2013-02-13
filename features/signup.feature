@debug
Feature: Sign up
  In order to use the provided service
  As a Guest
  I want to sign up for an user account

  Scenario: Sign up with valid data
    Given I am on Home page
    And I click on "Sign Up"
    When I click on "Create your Domain"
    And I agree with terms
    And I fill in all mandatory fields
    And I click on "Create Account"
    Then I should be redirected on Confirmation page

  @current
  Scenario: Admin confirms user registration
#	Given Admin logs in
#	And goes to "Admin::Dashboard"
#	And clicks on "Users"
#	And finds the user that registered at prev Scenario
#	When Admin clicks on "Confirm"
    Given I logged in as an admin
    When I confirm user's registration
    And I logout
	Then I can login as a user
