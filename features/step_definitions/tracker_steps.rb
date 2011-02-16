Given /^I have no page view$/ do
  PageView.all.each do |p|
    p.delete
  end
end

Then /^I should see (\d+) page view$/ do |count|
  PageView.all.size.should == count
end

Then /^I should see "([^"]*)" more page view for "([^"]*)"$/ do |addition_views, article|
  1.should == 0
end
