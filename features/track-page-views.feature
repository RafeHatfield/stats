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
	
	Scenario: track the page view for a given article
		Given "a test article" has "1" page view
		When I go to "a test article"
		Then I should see "2" page views for "a test article"		

  Scenario: Organic view
    When a page view has an organic referrer
    Then we store the keyphrase searched for and search engine used

