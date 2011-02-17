
Then /^I should see (\d+) page view$/ do |count|
  PageView.all.size.should == count
end

Then /^system should not track a page view for "([^"]*)"$/ do |article|
end

Given /^test article has no page view$/ do
  hash ={:page_title=>"Chocolate has an Expiration Date", :page_id=>"653476", :writer_id=>"731923", :page_url=>"http://www.suite101.com/content/chocolate-has-an-expiration-date-a347637"}
  page = Page.create(hash)
end

Then /^the system should record (\d+) page view for page id "([^"]*)"$/ do |count, page_id|
  page = Page.find(:page_id => page_id.to_i)
  page.page_views.size.should == count
end

Given /^"a test article" has "1" page view$/ do
  # Delete the existing page for "a test article" if it exists.
  existing_page = Page.find(:page_id => 15).first
  existing_page.delete if !existing_page.nil?
  
  # Create a fresh page for "a test article".
  new_page = Page.create(:page_id => 15, :page_url => "http://www.google.ca", :writer_id => 12345)
  
  # Add a page view to the new page.
  new_page.page_views << PageView.create(:cookie_id => 999999)
end

Then /^I should see "2" page views for "a test article"$/ do
  Page.find(:page_id => 15).first.page_views.size.should == 2
end