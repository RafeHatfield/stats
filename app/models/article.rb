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
  has_many :daily_domain_views, :dependent => :destroy

  validates_presence_of :suite101_article_id, :title, :writer_id, :permalink
  validates_uniqueness_of :suite101_article_id
  
  
  
  scope :with_daily_page_views_between, lambda {|start_date, end_date| joins(:daily_page_views) & DailyPageView.between(start_date,end_date)}
  scope :for_writer, lambda {|writer_id| where(:writer_id => writer_id)}
  
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
  
  def increment_domain_view_on(date, domain)
    date = date.to_date
    
    daily_domain_view = self.daily_domain_views.where(:date => date, :domain => domain).first
    if daily_domain_view
      daily_domain_view.increment!(:count)
      return daily_domain_view
    else
      self.daily_domain_views.create!(:date => date, :writer_id => self.writer_id, :domain => domain, :count => 1)
    end
  end
  
  def count_between(start_date, end_date)
    self.daily_page_views.between(start_date, end_date).sum("count")
  end
  
  def self.with_total_counts_for_writer_between(writer_id, start_date, end_date)
    article_counts = Article.where(:writer_id => writer_id).map{ |a| {:title => a.title, :permalink => a.permalink, :count => a.count_between(start_date, end_date)}}
    article_counts.sort_by{|tc| -tc[:count]}
  end
    
end
