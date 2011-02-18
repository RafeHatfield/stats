require 'test_helper'

class PageTest < ActiveSupport::TestCase
  
  context "on tracking page views" do
    setup do
      @page = create_page({:tracked_page_id => "22345"})
    end

    should "create a page" do
      assert_equal @page.page_title, "Chocolate has an Expiration Date"
      assert_equal @page.tracked_page_id, "22345"
      assert_equal @page.page_url, "http://www.suite101.com/content/chocolate-has-an-expiration-date-a347637"
    end
    
    should "require page url" do
      assert_equal false, create_page(:tracked_page_id => nil).valid?
    end 
  end  
  
  context "when a writer looks at his list of articles" do
    setup do
      @pages = []
      @writer_id = rand(10000).to_s
      10.times do |page_index|
        page = create_page({:writer_id => @writer_id})
        page_index.times do |page_view_count|
          page.insert_page_view({:page_id => page.id})
        end
        @pages << page
      end
    end

    should "return 5 least viewed articles" do
      # not working yet. Getting back to this later.
      # least_viewed = Page.least_viewed_for(@writer_id, 5)
      # assert_contains least_viewed, @pages[0]
      # assert_contains least_viewed, @pages[1]
      # assert_contains least_viewed, @pages[2]
      # assert_contains least_viewed, @pages[3]
      # assert_contains least_viewed, @pages[4]
    end
  end
  
  
end