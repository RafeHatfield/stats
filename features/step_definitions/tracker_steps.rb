Then /^I should see (\d+) page view$/ do |count|
  PageView.all.size.should == count
end

Given /^test article has no page view$/ do
  @page = create_page({:page_id => '234567'})
  @page.page_views.clear
end

Given /^I visit the test article (\d+) times within (\d+) minutes$/ do |visit_count, time_period|
  cookie_id = rand(1000)
  @page.insert_page_view({:cookie_id => cookie_id, :page_id => @page.id})
  @page.insert_page_view({:cookie_id => cookie_id, :page_id => @page.id})
end

Then /^the system should record (\d+) page view for the test article$/ do |view_count|
  @page.page_views.size.should == view_count
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

When /^a page view has an organic referrer$/ do
  # create new page view
end

Then /^we store the keyphrase searched for$/ do
  # new page view has keyword_phrase that is right  
end
