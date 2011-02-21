Given /^a Suite101 writer "Homer"$/ do
  @homer_id = rand(100000)
end

Given /^Homer has published articles with these pageviews lifetime:$/ do |article_table|
  article_table.hashes.each do |article|
    page = create_page(:tracked_page_id => rand(100000), :page_title => article[:Title].to_s, :writer_id => @homer_id)
    article[:Views].to_i.times do
      page.insert_page_view(params_for_page_view.merge!(:page_id => page.id))
    end
  end
end

When /^"Homer" visits Suite101 Stats$/ do 
  visit "http://localhost:3000/#{@homer_id}"
end

Then /^"Homer" sees 21 for "Total Pageviews"$/ do
  within("#total_page_views") do
    page.should have_content?("21")
  end
end




