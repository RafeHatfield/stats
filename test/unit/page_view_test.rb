require 'test_helper'

class PageViewTest < ActiveSupport::TestCase
  
  context "on tracking page views" do
    setup do
      @page = create_page
      @pageview = create_page_view
    end

    should "create a page view" do
      assert_equal @pageview.referer_url, "http://google.com"
    end
  end  
  
  context "when a visitor keeps refreshing a page" do
    setup do
      @page = create_page({:page_id => rand(1000).to_s})
      cookie_id = rand(1000).to_s
      @page.insert_page_view({:cookie_id => cookie_id, :page_id => @page.id})
      @page.insert_page_view({:cookie_id => cookie_id, :page_id => @page.id})
    end

    should "record only 1 page view within 30 minutes" do
      assert_equal 1, @page.page_views.size
    end
  end
  
  
end