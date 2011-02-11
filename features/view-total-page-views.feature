Feature: View total page views
	In order to retain our writers
	As Suite101 Product Manager
	I want to show our writers their lifetime total page views

	Background:
	Given a Suite101 writer "Homer"
		And Homer has published 6 articles
		And these are the per-article pageviews lifetime:
		|ID|Title|views|
		|1|Article 1|100|
		|2|Article 2|200|
		|3|Article 3|300|
		|4|Article 4|400|
		|5|Article 5|500|
		|6|Article 6|600|
	
	Scenario: See total number of page views
	When "Homer" logs into Suite101 Stats
		And "Homer" looks at "Total Pageviews"
	Then "Homer" sees 2100

	Scenario: See total number of page views by week
	When "Homer" logs into Suite101 Stats
		And "Homer" looks at pageviews by "week"
	Then "Homer" sees a graph of total "pageviews by week".
	
	Scenario: See total number of page views from My Suite
	
	Scenario: See a graph of total page view data by day on My Suite

