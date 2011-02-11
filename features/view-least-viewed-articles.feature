Feature: View least successful articles
In order to reduce effort on articles not generating any traffic
As a Suite101 writer with more than 20 articles
I want to see which of my articles are generating the least page views in the last week
	
	Background:
		Given I am a Suite101 writer
			And I have 21 articles published
			And these are the per-article pageviews in the last week:
			|ID|Title|views|
			|1|Article 1|100|
			|2|Article 2|200|
			|3|Article 3|300|
			|4|Article 4|400|
			|5|Article 5|500|
			|6|Article 6|600|
			|7|Article 7|700|
			|8|Article 8|800|
			|9|Article 9|900|
			|10|Article 10|1000|
			|11|Article 11|100|
			|12|Article 12|200|
			|13|Article 13|300|
			|14|Article 14|400|
			|15|Article 15|500|
			|16|Article 16|600|
			|17|Article 17|700|
			|18|Article 18|800|
			|19|Article 19|900|
			|20|Article 20|1000|
		
	Scenario: View 5 (plus ties) lowest traffic articles
		Given I am logged into Suite101 Stats 
		When I click "Which articles aren't getting traffic"
		Then I should see the following articles:
			|ID|Title|views|
			|1|Article 1|100|
			|11|Article 11|100|
			|2|Article 2|200|
			|12|Article 12|200|
			|3|Article 3|300|
			|13|Article 13|300|
