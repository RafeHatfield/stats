# Background:
# 	Given an article "My test article"
# 		And a reader "Northrop Frye"
# 
# Scenario: Count number of times an article is viewed
# 	Given "My test article" has 1 view
# 	When "Northrop Frye" visits "My test article"
# 	Then "My test article" has 2 views
Given /^I have no page view$/ do
  PageView.all.each do |p|
    p.delete
  end
end

Then /^I should see (\d+) page view$/ do |count|
  PageView.all.size.should == count
end
