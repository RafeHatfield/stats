# == Schema Information
# Schema version: 20110228215559
#
# Table name: articles
#
#  id                  :integer         not null, primary key
#  suite101_article_id :integer
#  title               :string(255)
#  writer_id           :integer
#  permalink           :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

class Article < ActiveRecord::Base

  has_many :daily_page_views, :dependent => :destroy
  has_many :daily_keyphrase_views, :dependent => :destroy

  validates_presence_of :suite101_article_id, :title, :writer_id, :permalink
  validates_uniqueness_of :suite101_article_id
  
  def increment_page_view_on(date)
    # Strip the time part off of date.
    date = date.to_date
    
    daily_page_view = self.daily_page_views.where(:date => date).first
    if daily_page_view
      daily_page_view.increment!(:count)
      return daily_page_view
    else
      self.daily_page_views.create!(:date => date, :writer_id => self.writer_id, :count => 1)
    end
  end
  
  def increment_keyphrase_view_on(date,keyphrase)
    # Strip the time part off of date.
    date = date.to_date
    daily_keyphrase_view = self.daily_keyphrase_views.where(:date => date, :keyphrase => keyphrase).first
    if daily_keyphrase_view
      daily_keyphrase_view.increment!(:count)
      return daily_keyphrase_view
    else
      self.daily_keyphrase_views.create!(:date => date, :writer_id => self.writer_id, :keyphrase => keyphrase, :count => 1)
    end
  end
  
  def view_count_between(start_date, end_date)
    start_date = start_date.to_date
    end_date = end_date.to_date
    views = self.daily_page_views.where(:date => start_date...end_date + 1.day).all
    # Note: With "..." range rails generates a sql where clause with date >= d1, date < d2 so we add an extra day to include today) 
    
    return views.sum{|v| v.count}
  end
  
  def self.find_and_update_title_or_create(data)
    article = Article.where(:suite101_article_id => data[:suite101_article_id]).first
    
    if article
      article.update_attribute(:title, data[:title])
      return article
    else
      Article.create!(:suite101_article_id => data[:suite101_article_id], :title => data[:title], :writer_id => data[:writer_id], :permalink => data[:permalink])
    end
  end
  
  def self.title_counts_for_writer_between(writer_id, start_date, end_date)
    writer_articles = Article.where(:writer_id => writer_id).all
    
    writer_articles.map {|a| [a.title, a.view_count_between(start_date, end_date)]}
    
  end
  
  
  
end
