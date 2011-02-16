
Then /^I should see (\d+) page view$/ do |count|
  PageView.all.size.should == count
end


Then /^I should see "([^"]*)" page views for "([^"]*)"$/ do |views, article|
  page = Page.find(:page_id => 15).first
  page.nil?.should == false
  page.page_views.size.should == 2
end

Given /^"([^"]*)" has "([^"]*)" page view$/ do |article, current_views|

  # Zero out page views for this page or create a new page
  if !(page = Page.find(:page_id => 15).first).nil?
    page.page_views.clear
  else
    page = Page.create(:page_id => 15, :page_url => "http://www.google.ca", :writer_id => 12345)
  end
  
  # Add a page view for article
  page_view = PageView.create(:cookie_id => rand(1000), :page_id => 15)
  page.page_views << page_view
  
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

