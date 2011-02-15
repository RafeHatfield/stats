class PageViewTest < Test::Unit::TestCase
  
  context "on tracking page views" do
    setup do
      hash ={:page_title=>"Chocolate has an Expiration Date", :visited_at=>Time.now, :page_id=>"653476", :writer_id=>"731923", :page_url=>"http://www.suite101.com/content/chocolate-has-an-expiration-date-a347637", :referer_url=>nil}
      @pageview = PageView.create(hash)
    end

    should "create page view" do
      @pageview.page_title.should == "Chocolate has an Expiration Date"
    end
  end
  
end