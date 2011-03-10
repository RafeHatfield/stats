require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  setup do
    @article_id = 45678
    @valid_raw_data = {
      :permalink =>"http://www.animal.intranet.suite101.com/content/the-gmhp-shiitake-mushroom-growing-kit-a120501", 
      :title => "The GMHP Shiitake Mushroom Growing Kit", 
      :cookie_id => "#{rand(10000)}", 
      :suite101_article_id => @article_id, 
      :referrer_url => "http://www.google.ca/search?q=awesome+sauce&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a", 
      :writer_id => "658084", 
      :date => "{ts '2011-03-02 12:58:52'}"
    }
  end
  
  context "perform with valid data" do
    setup do
      RawPageViewJob.perform(ActiveSupport::JSON.encode(@valid_raw_data))
      @article = Article.where(:suite101_article_id => @article_id).first
    end
  
    should "create an article" do
      assert @article
    end  
    should "create a raw page view" do
      assert_equal 1, RawPageView.where(:suite101_article_id => @article_id).count
    end
    should "add a daily page view to the viewed article on the proper day" do
      assert_equal 1, @article.daily_page_views.where(:date => "2011-03-02".to_date).count
    end
    should "add a daily keyphrase view to the viewed article on the proper day" do
      assert_equal 1, @article.daily_keyphrase_views.where(:date => "2011-03-02".to_date, :keyphrase => "awesome sauce").count
    end
    should "add a daily domain view to the viewed article on the proper day" do
      assert_equal 1, @article.daily_domain_views.where(:date => "2011-03-02".to_date, :domain => "www.google.ca").count
    end
    
  end
  
  context "perform with a blank referrer url" do
    setup do
      RawPageViewJob.perform(ActiveSupport::JSON.encode(@valid_raw_data.merge!(:referrer_url => nil)))
      @article = Article.where(:suite101_article_id => @article_id).first
    end
    
    should "create an article" do
      assert @article
    end
    should "create a raw page view" do
      assert_equal 1, RawPageView.where(:suite101_article_id => @article_id).count
    end
    should "add a daily page view to the viewed article on the proper day" do
      assert_equal 1, @article.daily_page_views.where(:date => "2011-03-02".to_date).count
    end
    should "not add a daily keyphrase view to the viewed article on the proper day" do
      assert_equal 0, @article.daily_keyphrase_views.where(:date => "2011-03-02".to_date, :keyphrase => "awesome sauce").count
    end
    should "not add a daily domain view to the viewed article on the proper day" do
      assert_equal 0, @article.daily_domain_views.where(:date => "2011-03-02".to_date, :domain => "www.google.ca").count
    end
    
  end

end
