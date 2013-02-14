@debug
Feature: User manages media content
  In order to share content with contacts
  As a User
  I want to create new set
  
Scenario: creating a set
	Given I logged in with 'user1@example.com' and 'secret'
	And I am on the "Media" page
	And I click on "Add Media" 
	And I completed all steps of wizard
	When I click on "Publish"
	Then I should be redirected to View Set page
	
