require 'test_helper'

class DailyDomainViewTest < ActiveSupport::TestCase

  context "validations" do  
    should "require a date" do
      assert_equal false, FactoryGirl.build(:daily_domain_view, :date => nil).valid?
    end
    should "require a article_id" do
      assert_equal false, FactoryGirl.build(:daily_domain_view, :article_id => nil).valid?
    end
    should "require a writer_id" do
      assert_equal false, FactoryGirl.build(:daily_domain_view, :writer_id => nil).valid?
    end
    should "require a count" do
      assert_equal false, FactoryGirl.build(:daily_domain_view, :writer_id => nil).valid?
    end
    should "have an article" do
      assert FactoryGirl.build(:daily_domain_view).respond_to?(:article)
    end
  end
  
  context "getting domain counts between two dates" do
    should "get the right domain counts ordered by count descending" do
      writer_id = 333
      article = FactoryGirl.create(:article, :writer_id => writer_id)
      domain1 = "google.com"
      domain2 = "yahoo.ca"
      3.times do
        article.increment_domain_view_on(Date.yesterday, domain1)
      end
      2.times do
        article.increment_domain_view_on(Date.yesterday, domain2)
      end
      6.times do
        article.increment_domain_view_on(Date.today, domain1)
      end

      expected_domain_counts = [[domain1, 3+6], [domain2, 2]]
      assert_equal expected_domain_counts, DailyDomainView.domains_with_total_counts_for_writer_between(writer_id, Date.yesterday, Date.today)
    end
    
  end

end
