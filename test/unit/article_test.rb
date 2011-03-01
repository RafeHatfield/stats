require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  
  context "validations" do
    setup do
    end
    
    should "require a suite101_article_id" do
      assert_equal false, FactoryGirl.build(:article, :suite101_article_id => nil).valid?
    end
    should "require a title" do
      assert_equal false, FactoryGirl.build(:article, :title => nil).valid?
    end
    should "require a writer_id" do
      assert_equal false, FactoryGirl.build(:article, :writer_id => nil).valid?
    end
    should "require a permalink" do
      assert_equal false, FactoryGirl.build(:article, :permalink => nil).valid?
    end
    should "not accept a zero-length title" do
      assert_equal false, FactoryGirl.build(:article, :title => "").valid?
    end
    should "not accept a zero-length permalink" do
      assert_equal false, FactoryGirl.build(:article, :permalink => "").valid?
    end
    
    should "require suite101_article_id to be unique" do
      suite101_article_id = 999
      article1 = FactoryGirl.build(:article, :suite101_article_id => suite101_article_id)
      article1.save!
      article2 = FactoryGirl.build(:article, :suite101_article_id => suite101_article_id)
      assert_equal false, article2.valid?
    end
    
    should "have many page views" do
      article = FactoryGirl.build(:article)
      assert article.respond_to?(:daily_page_views)
    end
  end
  
  context "incrementing daily page views" do
    
    setup do
      a_id = 123
      Article.where(:suite101_article_id => a_id).delete_all
      @article = FactoryGirl.create(:article, :suite101_article_id => a_id)
    end
    
    should "give 1 page view if there are none for today" do
      @article.increment_page_view_on(Date.today)
      assert_equal 1, @article.daily_page_views.where(:date => Date.today).first.count
    end
    
    should "give 2 page view if there is already 1 for today" do
      @article.increment_page_view_on(Date.today)
      @article.increment_page_view_on(Date.today)
      assert_equal 2, @article.daily_page_views.where(:date => Date.today).first.count
    end
    
  end
  
  context "find and update title or create" do
    
    should "create an article if it doesn't exist" do
      article_data = FactoryGirl.attributes_for(:article, :suite101_article_id => 111)
      article = Article.find_and_update_title_or_create(article_data)
      assert Article.exists?(:suite101_article_id => 111)
    end
    
    should "update the title of an article that exists" do
      article_data = FactoryGirl.attributes_for(:article, :suite101_article_id => 112, :title => "first")
      article = FactoryGirl.create(:article, article_data)
      Article.find_and_update_title_or_create(article_data.merge!(:title => "second"))
      article.reload
      assert article.title == "second"
    end
    
    
  end
  
  
  
  

end
