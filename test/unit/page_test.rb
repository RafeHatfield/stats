require 'test_helper'

class PageTest < ActiveSupport::TestCase
  
  context "on tracking page views" do
    setup do
      @page = create_page({:page_id => "22345"})
    end

    should "create a page" do
      assert_equal @page.page_title, "Chocolate has an Expiration Date"
      assert_equal @page.page_id, "22345"
      assert_equal @page.page_url, "http://www.suite101.com/content/chocolate-has-an-expiration-date-a347637"
    end
    
    should "require page url" do
      assert_equal false, create_page(:page_id => nil).valid?
    end 
  end  
  
end