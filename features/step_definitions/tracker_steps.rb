Given /^I have no page view$/ do
  PageView.all.each do |p|
    p.delete
  end
end

Then /^I should see (\d+) page view$/ do |count|
  PageView.all.size.should == count
end

Then /^I should see "([^"]*)" page views for "([^"]*)"$/ do |views, article|
  Page.find(:article_id => 15).page_views.size.should == 1
end

Given /^"([^"]*)" has "([^"]*)" page view$/ do |article, current_views|
  # Zero out page views for this article
  # Add current_views page view for article

end