require 'test_helper'

class RawPageViewTest < ActiveSupport::TestCase

  setup do
    # Clear the uniqueness cache for every test.
    RawPageView.uniqueness_cache.flush_all
  end

  context "validations" do
    should "require a title" do
      assert_equal false, FactoryGirl.build(:raw_page_view, :title => nil).valid?
    end
    should "require a suite101_article_id" do
      assert_equal false, FactoryGirl.build(:raw_page_view, :suite101_article_id => nil).valid?
    end
    should "require a permalink" do
      assert_equal false, FactoryGirl.build(:raw_page_view, :permalink => nil).valid?
    end
    should "require a writer_id" do
      assert_equal false, FactoryGirl.build(:raw_page_view, :writer_id => nil).valid?
    end
    should "require a cookie_id" do
      assert_equal false, FactoryGirl.build(:raw_page_view, :cookie_id => nil).valid?
    end
    should "require a date" do
      assert_equal false, FactoryGirl.build(:raw_page_view, :date => nil).valid?
    end
    should "require writer_id to be an integer" do
      assert_equal false, FactoryGirl.build(:raw_page_view, :writer_id => "notanint").valid?
    end
    should "require suite101_article_id to be an integer" do
      assert_equal false, FactoryGirl.build(:raw_page_view, :suite101_article_id => "notanint").valid?
    end
  end
  
  context "uniqueness" do
    
    setup do  
      first_view = FactoryGirl.create(:raw_page_view, :date => Time.now)
      first_view.insert_into_uniqueness_cache
    end
   
    should "not be unique if the same payload was recorded less than 30 minutes ago" do
      second_view = FactoryGirl.build(:raw_page_view, :date => 10.minutes.from_now)
      assert_equal false, second_view.unique?
    end

    should "be unique if the same payload was seen more than 30 minutes ago" do
      second_view = FactoryGirl.build(:raw_page_view, :date => 50.minutes.from_now)
      assert_equal true, second_view.unique?
    end
    
    should "be unique if the same payload hasn't been seen before" do
      second_view = FactoryGirl.build(:raw_page_view, :cookie_id => "superrandom", :date => 10.minutes.from_now)
      assert_equal true, second_view.unique?
    end

  end
  


end
