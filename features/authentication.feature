Feature: Provide authentication functionality for Suite101 Stats
	In order to stop other people from seeing my stats
	As a Suite101 writer
	I want to have my stats be password protected

	Background:
		Given a Suite101 writer "Homer"
			And a Suite101 writer "Plato"
	
	Scenario: Successful login
		Given "Homer" has a password "foo"
			And "Homer" is on the login page
		When "Homer" enters "homer@greece.gr" in the "email" field
			And "Homer" enters "foo" in the "password" field
		Then "Homer" successfully logs in
			And "Homer" should see "Stats Dashboard"
		
	Scenario: Unsuccessful login (first 2)
		Given "Homer" has a password "foo"
			And "Homer" is on the login page
		When "Homer" enters "homer@greece.gr" in the "email" field
			And "Homer" enters "bar" in the "password" field
		Then "Homer" sees log in failed.
	
	Scenario: Unsuccessful login 3 times in a row
	#Reset password - mail them | block ip for a few hours

