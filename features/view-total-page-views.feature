# @pageviews	@total_views
# Feature: View total page views
# 	In order to retain our writers
# 	As Suite101 Product Manager
# 	I want to show our writers their lifetime total page views
# 
# 	Background:
# 	Given a Suite101 writer "Homer"
# 		And Homer has published some articles
# 	
# 	Scenario: See total number of "pageviews"
# 		When "Homer" logs into Suite101 Stats
# 			And "Homer" looks at "Total Pageviews"
# 		Then "Homer" see the sum of all his "pageviews"
# 
# 	Scenario: See total number of "pageviews" by week
# 		When "Homer" logs into Suite101 Stats
# 			And "Homer" looks at "pageviews" by week
# 		Then "Homer" sees a graph of "total pageviews" by week
# 	
# 	Scenario: See total number of page views from My Suite
# 		When "Homer" is on the "My Suite" page
# 			And "Homer" looks at "Total Pageviews"
# 		Then "Homer" see the sum of all his "pageviews"
# 	
# 	Scenario: See a graph of total page view data by day on My Suite
# 		When "Homer" is on the "My Suite" page
# 			And "Homer" looks at "pageviews" by week
# 		Then "Homer" sees a graph of "total pageviews" by week
