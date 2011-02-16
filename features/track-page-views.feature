#Goal: Identify which articles drive traffic
#	In order to target future articles to subjects that generate the most traffic
#	As a Suite101 writer
#	I want to see which of my articles are generating the most page views

@tracking @pageviews
Feature: Track page views
In order to retain valuable writers
As Suite101 Product Manager
I want to track each articles pageviews
So I can show writers how their articles are performing
	Background:
	
	# Scenario: track a page view
	# 		Given I have no page view
	# 		When I go to a tracking page
	# 		Then I should see "1" page view
	# 	
	
	Scenario: track the page view for a given article
		Given "a test article" has "1" page view
		When I go to "a test article"
		Then I should see "2" page views for "a test article"		
	
	# 
	# Scenario: a reader visit a page multiple times
	# 	Given I have been on "test article" in the past "30" minutes
	# 	When I go to an article "test article"
	# 	Then system should not track a page view for "test article"
	# 	

	# Scenario Outline: track page view
	# 	Given a reader is coming from "<source>"
	# 	When they visit an article
	# 	Then we track a "<type>" page view
	# 
	# 	Examples:
	# 		|source|type|
	# 		|Suite101|internal|
	# 		|Google|organic|
	# 		|Email|direct|
	# 		# |typing suite101.com into browser|direct|
	# 		# |Bing|organic|
	# 	
	# Scenario: Organic view
	# 	When there is an organic view tracked
	# 	Then we store the keyphrase searched for
	# 	
	# Scenario: Internal view
	# 	When there is an internal view tracked
	# 	Then we store the entrance path to the article
	# 	
	# Scenario: Direct view
	# 	When there is a direct view tracked
	# 	Then we store the entrance source
	
	
		# Given "Northrop Frye" is on the page "Previous Path" at "Suite101"
		# 	When "Northrop Frye" visits "My test article"
		# 	Then "My test article" gets a view with "Suite101" as the source
		# 		And "My test article" tracks an entrance path from "Previous Path"
		# 		And that "My test article" received an "internal" view
		# 		
		# Scenario: Organic page view
		# 	Given that "Google" is a search engine
		# 		And "My test article" has 1 view
		# 		And "Northrop Frye" searched for "My test keyphrase" on "Google"
		# 		And "Northrop Frye" clicks on a link to "My test article"
		# 	When "Northrop Frye" visits "My test article"
		# 	Then "Anthony" can see that "My test article" has 2 views
		# 		And that "Google" has sent one view to "My test article"
		# 		And that "searching" "My test keyphrase" led to a view of "My test article"
		# 		And that "My test article" received an "organic" view
		# 		
		# Scenario: Direct page view
		# 	Given that "Facebook" is a social network
		# 		And "My test article" has 1 view
		# 		And "Northrop Frye"'s friends shared a link to "My test article" on "Facebook"
		# 		And "Northrop Frye" clicks on a link to "My test article"
		# 	When "Northrop Frye" visits "My test article"
		# 	Then "Anthony" can see that "My test article" has 2 views
		# 		And that "Facebook" has sent one view to "My test article"
		# 		And that "sharing" "My test article" led to a view of "My test article"
		# 		And that "My test article" received a "direct" view
		# 	
		# 
