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
		Given I have no page view
	
	Scenario: track a page view
		When I go to a tracking page
		Then I should see 1 page view
			
	# Scenario: Internal page view
	# 	Given "Northrop Frye" is on the page "Previous Path" at "Suite101"
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