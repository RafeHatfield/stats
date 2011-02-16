Then /^I should see (\d+) page view$/ do |count|
  PageView.all.size.should == count
end


Then /^I should see "([^"]*)" page views for "([^"]*)"$/ do |views, article|
  page = Page.find(:page_id => 15)
  page.empty?.should == false
  page.page_views.size.should == 1
end

Given /^"([^"]*)" has "([^"]*)" page view$/ do |article, current_views|
  # Zero out page views for this article
  # Add current_views page view for article
  if !(page = Page.find(:page_id => 15)).empty?
    page.page_views do |pv|
      pv.delete
    end
  end
end

Then /^system should not track a page view for "([^"]*)"$/ do |article|

Given /^test article has no page view$/ do
  hash ={:page_title=>"Chocolate has an Expiration Date", :page_id=>"653476", :writer_id=>"731923", :page_url=>"http://www.suite101.com/content/chocolate-has-an-expiration-date-a347637"}
  page = Page.create(hash)
end

Then /^the system should record (\d+) page view for page id "([^"]*)"$/ do |count, page_id|
  page = Page.find(:page_id => page_id.to_i)
  page.page_views.size.should == count
end

