#Goal: Identify which articles drive traffic
#	In order to target future articles to subjects that generate the most traffic
#	As a Suite101 writer
#	I want to see which of my articles are generating the most page views

Feature: Track page views
In order to protect revenue
As Suite101 Product Manager
I want to know which articles are getting the most page views

	Background:
		Given an article "My test article"
			And "My test article" has 1 view
			And an analyst "Anthony"
			And a reader "Northrop Frye"
	
	Scenario: Count number of times an article is viewed
		When "Northrop Frye" visits "My test article"
		Then "My test article" has 2 views
	
	Scenario: Internal page view
		Given an article "My referring article"
			And "Northrop Frye" is reading "My referring article"
			And "Northrop Frye" clicks on a link to "My test article"
		When "Northrop Frye" visits "My test article"
		Then "Anthony" can see that "My test article" has 2 views
			And that "Suite101" has sent one view to "My test article"
			And that "reading" "My referring article" led to a view of "My test article"
			And that "My test article" received an "internal" view
			
	Scenario: Organic page view
		Given that "Google" is a search engine
			And "Northrop Frye" searched for "My test keyphrase" on "Google"
			And "Northrop Frye" clicks on a link to "My test article"
		When "Northrop Frye" visits "My test article"
		Then "Anthony" can see that "My test article" has 2 views
			And that "Google" has sent one view to "My test article"
			And that "searching" "My test keyphrase" led to a view of "My test article"
			And that "My test article" received an "organic" view
			
	Scenario: Direct page view
		Given that "Facebook" is a social network
			And "Northrop Frye"'s friends shared a link to "My test article" on "Facebook"
			And "Northrop Frye" clicks on a link to "My test article"
		When "Northrop Frye" visits "My test article"
		Then "Anthony" can see that "My test article" has 2 views
			And that "Facebook" has sent one view to "My test article"
			And that "sharing" "My test article" led to a view of "My test article"
			And that "My test article" received a "direct" view
		
	