Then /^I should see (\d+) page view$/ do |count|
  PageView.all.size.should == count
end

Given /^test article has no page view$/ do
  hash ={:page_title=>"Chocolate has an Expiration Date", :page_url=>"http://www.suite101.com/content/chocolate-has-an-expiration-date-a347637", :page_id=>rand(10000), :writer_id=>"731923"}
  
  @page = Page.create(hash)
  @page.page_views.clear
end

Given /^I visit the test article (\d+) times within (\d+) minutes$/ do |visit_count, time_period|
  cookie_id = rand(1000)
  @page.insert_page_views({:cookie_id => cookie_id, :page_id => @page.id})
  @page.insert_page_views({:cookie_id => cookie_id, :page_id => @page.id})
end

Then /^the system should record (\d+) page view for the test article$/ do |view_count|
  @page.page_views.size.should == view_count
end