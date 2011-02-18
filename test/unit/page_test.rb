require 'test_helper'

class PageTest < ActiveSupport::TestCase

  context "validations" do
    should "require a page_title" do 
      assert_equal false, create_page(:page_title => nil).valid?
    end
    should "require a tracked_page_id" do
      assert_equal false, create_page(:tracked_page_id => nil).valid?
    end
    should "require a page_url" do
      assert_equal false, create_page(:page_url => nil).valid?
    end 
    should "require a writer_id" do
      assert_equal false, create_page(:writer_id => nil).valid?
    end   
    should "require tracked_page_id to be unique" do
      page_params = params_for_page.merge(:tracked_page_id => 1)
      Page.create(page_params)
      assert_equal false, Page.new(page_params).valid?
    end
  end
  
  context "associations" do
    should "have page_views" do
      assert_equal true, create_page.respond_to?(:page_views)
    end
  end

  context "factory" do
    should "create a valid page" do
      assert_equal true, create_page.valid?
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
      least_viewed = Page.least_viewed_for(@writer_id, 5)
      assert_contains least_viewed, @pages[0]
      assert_contains least_viewed, @pages[1]
      assert_contains least_viewed, @pages[2]
      assert_contains least_viewed, @pages[3]
      assert_contains least_viewed, @pages[4]
    end
  end
  
  
end