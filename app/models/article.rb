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

  has_many :daily_page_views

  validates_presence_of :suite101_article_id, :title, :writer_id, :permalink
  validates_uniqueness_of :suite101_article_id
  
  def increment_page_view_on(date)
    daily_page_view = self.daily_page_views.where(:date => date).first
    if daily_page_view
      daily_page_view.increment!(:count)
    else
      self.daily_page_views.create(:date => date, :writer_id => self.writer_id, :count => 1)
    end
  end
  
  def self.find_and_update_title_or_create(data)
    article = Article.where(:suite101_article_id => data[:suite101_article_id]).first
    
    if article
      article.update_attribute(:title, data[:title])
    else
      Article.create!(:suite101_article_id => data[:suite101_article_id], :title => data[:title], :writer_id => data[:writer_id], :permalink => data[:permalink])
    end
  end
  
end
