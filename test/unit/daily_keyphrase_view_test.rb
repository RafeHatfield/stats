require 'test_helper'

class DailyKeyphraseViewTest < ActiveSupport::TestCase
  context "validations" do
    setup do
    end
    
    should "require a date" do
      assert_equal false, FactoryGirl.build(:daily_keyphrase_view, :date => nil).valid?
    end
    should "require a article_id" do
      assert_equal false, FactoryGirl.build(:daily_keyphrase_view, :article_id => nil).valid?
    end
    should "require a writer_id" do
      assert_equal false, FactoryGirl.build(:daily_keyphrase_view, :writer_id => nil).valid?
    end
    should "require a count" do
      assert_equal false, FactoryGirl.build(:daily_keyphrase_view, :writer_id => nil).valid?
    end
    
    should "have an article" do
      assert FactoryGirl.build(:daily_keyphrase_view).respond_to?(:article)
    end
    
    
  end
end
