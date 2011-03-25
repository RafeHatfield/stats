class Article < ActiveRecord::Base

  has_many :daily_page_views, :dependent => :destroy
  has_many :daily_keyphrase_views, :dependent => :destroy
  has_many :daily_domain_views, :dependent => :destroy

  validates_presence_of :id, :title, :writer_id, :permalink
  validates_uniqueness_of :id
    
  def self.find_and_update_title_or_create(data)
    id = data[:id]

    if Article.exists?(id)
      article = Article.find(id)
      article.update_attribute(:title, data[:title])
      return article
    else
      Article.create!(:title => data[:title], :writer_id => data[:writer_id], :permalink => data[:permalink]){|a| a.id = id}
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
  
  def display_title
    URI.decode(self.title)
  end
  
  # def self.with_total_counts_for_writer_between(writer_id, start_date, end_date)
  #   article_counts = Article.where(:writer_id => writer_id).map{ |a| {:id => a.id, :title => a.display_title, :permalink => a.permalink, :count => a.count_between(start_date, end_date)}}
  #   article_counts.sort_by{|tc| -tc[:count]}
  # end
  
  def self.with_total_counts_for_writer_between(writer_id, start_date, end_date)
    DailyPageView.
      select("article_id, title, permalink, SUM(count) as page_views_count").
      where(:writer_id => writer_id).
      between(start_date, end_date).
      joins(:article).
      group("article_id, title, permalink").
      order("page_views_count DESC")
  end
  
    
end
