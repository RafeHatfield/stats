require 'test_helper'

class RawPageViewTest < ActiveSupport::TestCase

  context "validations" do
    should "require a page title" do
      assert_equal false, FactoryGirl.build(:raw_page_view, :page_title => nil).valid?
    end
    should "require a tracked_page_id" do
      assert_equal false, FactoryGirl.build(:raw_page_view, :tracked_page_id => nil).valid?
    end
    should "require a page_url" do
      assert_equal false, FactoryGirl.build(:raw_page_view, :page_url => nil).valid?
    end
    should "require a writer_id" do
      assert_equal false, FactoryGirl.build(:raw_page_view, :writer_id => nil).valid?
    end
    should "require a cookie_id" do
      assert_equal false, FactoryGirl.build(:raw_page_view, :cookie_id => nil).valid?
    end
    should "require a visited_at" do
      assert_equal false, FactoryGirl.build(:raw_page_view, :visited_at => nil).valid?
    end
  end
  
  context "uniqueness" do
    
    setup do
      # Clear memcache
      RawPageView.uniqueness_cache.flush_all
      
      @first_view_data = {
        :tracked_page_id => 65432,
        :writer_id => 12345,
        :cookie_id => "iamarandomcookie"
      }
      first_view = FactoryGirl.build(:raw_page_view, @first_view_data)
      first_view.save
    end
   
    should "not be valid if the same payload was recorded less than 30 minutes ago" do
      second_view = FactoryGirl.build(:raw_page_view, @first_view_data.merge!(:visited_at => 10.minutes.from_now))
      assert_equal false, second_view.valid?
    end

    should "be valid if the same payload was seen more than 30 minutes ago" do
      second_view = FactoryGirl.build(:raw_page_view, @first_view_data.merge!(:visited_at => 50.minutes.from_now))
      assert_equal true, second_view.valid?
    end
    
    should "be valid if the same payload hasn't been seen before" do
      second_view = FactoryGirl.build(:raw_page_view, @first_view_data.merge!(:cookie_id => "superrandom"))
      assert_equal true, second_view.valid?
    end

  end
  


end
