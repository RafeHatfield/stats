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
  
  def self.find_and_update_title_or_create(data)
    article = Article.where(:suite101_article_id => data[:suite101_article_id]).first
    
    if article
      article.update_attribute(:title, data[:title])
      return article
    else
      Article.create!(:suite101_article_id => data[:suite101_article_id], :title => data[:title], :writer_id => data[:writer_id], :permalink => data[:permalink])
    end
  end
  
  def increment_page_view_on(date)
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
    date = date.to_date
    
    daily_keyphrase_view = self.daily_keyphrase_views.where(:date => date, :keyphrase => keyphrase).first
    if daily_keyphrase_view
      daily_keyphrase_view.increment!(:count)
      return daily_keyphrase_view
    else
      self.daily_keyphrase_views.create!(:date => date, :writer_id => self.writer_id, :keyphrase => keyphrase, :count => 1)
    end
  end
  
  def count_between(start_date, end_date)
    self.daily_page_views.between(start_date, end_date).sum("count")
  end
  
  def self.titles_with_total_counts_for_writer_between(writer_id, start_date, end_date)
    title_counts = Article.where(:writer_id => writer_id).map{ |a| [a.title, a.count_between(start_date, end_date)]}
    title_counts.sort_by{|tc| -tc[1]}
  end
    
end
