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
  
  context "inserting a page view" do
    context "a unique page view" do
      should "create a new page view" do
        page = create_page
        page.insert_page_view(params_for_page_view)
        assert_equal 1, page.page_views.size
        assert_equal true, page.page_views.first.valid?
      end
    end
    
    context "a non-unique page view" do
      should "not create a new page view" do
        page = create_page
        page.insert_page_view(params_for_page_view.merge!(:cookie_id => 1))
        assert_equal 1, page.page_views.size
        page.insert_page_view(params_for_page_view.merge!(:cookie_id => 1))
        assert_equal 1, page.page_views.size
      end
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

  end
  
  
end