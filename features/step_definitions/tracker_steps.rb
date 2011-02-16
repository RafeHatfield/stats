Given /^I have no page view$/ do
  PageView.all.each do |p|
    p.delete
  end
end

Then /^I should see (\d+) page view$/ do |count|
  PageView.all.size.should == count
end

Then /^system should not track a page view for "([^"]*)"$/ do |article|
  
end
