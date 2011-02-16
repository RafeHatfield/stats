Given /^I have no page view$/ do
  PageView.all.each do |p|
    p.delete
  end
end

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
  
end

