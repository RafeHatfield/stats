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
  
end