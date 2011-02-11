# Background:
# 	Given an article "My test article"
# 		And a reader "Northrop Frye"
# 
# Scenario: Count number of times an article is viewed
# 	Given "My test article" has 1 view
# 	When "Northrop Frye" visits "My test article"
# 	Then "My test article" has 2 views

Given /^an article "([^"]*)"$/ do |article|
  Article.find_or_create_by_name!(article)
end

Given /^"([^"]*)" has [/d+] views?$/ do |article, view_count|
	#Set up our initial set of tracked views
end

Given /^a reader "([^"]*)"$/ do |reader|
	Reader.find_or_create_by_name!(reader)
end

Given /^"([^"]*)" visits "([^"]*)"$/ do |reader, article|
	#Here we track a view
end