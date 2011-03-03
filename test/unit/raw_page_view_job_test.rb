require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  
  context "perform with valid data" do
    setup do
      @article_id = 45678
      @valid_queue_data = ActiveSupport::JSON.encode({
        :page_url =>"http://www.animal.intranet.suite101.com/content/the-gmhp-shiitake-mushroom-growing-kit-a120501", 
        :page_title => "The GMHP Shiitake Mushroom Growing Kit", 
        :cookie_id => "#{rand(10000)}", 
        :tracked_page_id => @article_id, 
        :referrer_url => "http://www.google.ca/search?q=awesome+sauce&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a", 
        :writer_id => "658084", 
        :visited_at => "{ts '2011-03-02 12:58:52'}"
      })
      
      RawPageView.where(:tracked_page_id => @article_id).delete_all
      
    end
    
    should "create a raw page view" do
      RawPageViewJob.perform(@valid_queue_data)
      assert_equal 1, RawPageView.where(:tracked_page_id => @article_id).count
    end
    
    should "add a daily page view to the viewed article on the proper day" do
      article = Article.where(:suite101_article_id => @article_id).first
      if article
        article.daily_page_views.delete_all
      end
      
      RawPageViewJob.perform(@valid_queue_data)
      article = Article.where(:suite101_article_id => @article_id).first
      assert article
      assert_equal 1, article.daily_page_views.where(:date => "2011-03-02".to_date).count
      
    end
    
    should "add a daily keyphrase view to the viewed article on the proper day" do
      article = Article.where(:suite101_article_id => @article_id).first
      if article
        article.daily_keyphrase_views.delete_all
      end

      RawPageViewJob.perform(@valid_queue_data)
      article = Article.where(:suite101_article_id => @article_id).first
      assert article
      assert_equal 1, article.daily_keyphrase_views.where(:date => "2011-03-02".to_date, :keyphrase => "awesome sauce").count
    end
    
  end

end
