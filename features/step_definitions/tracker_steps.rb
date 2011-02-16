Then /^I should see (\d+) page view$/ do |count|
  PageView.all.size.should == count
end

Given /^test article has no page view$/ do
  hash ={:page_title=>"Chocolate has an Expiration Date", :page_id=>"653476", :writer_id=>"731923", :page_url=>"http://www.suite101.com/content/chocolate-has-an-expiration-date-a347637"}
  page = Page.create(hash)
end

Then /^the system should record (\d+) page view for page id "([^"]*)"$/ do |count, page_id|
  page = Page.find(:page_id => page_id.to_i)
  page.page_views.size.should == count
end
