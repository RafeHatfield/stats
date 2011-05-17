class DailyPageView < ActiveRecord::Base

  belongs_to :article

  validates_presence_of :date, :article_id, :count, :writer_id
  
  scope :between, lambda {|start_date, end_date| where(:date => start_date.to_date...(end_date.to_date + 1.day)) }
  scope :partitioned, lambda {|writer_id| where(:partition_id => writer_id.to_i % PARTITION_SIZE) }
  
  # Get the number of views for all articles for writer_id on each day between and including start_date and end_date.
  def self.counts_for_writer_between(writer_id, start_date, end_date)
    set_table_name 'daily_page_views_master'
    
    date_counts = DailyPageView.partitioned(writer_id).select("date, sum(count) as count").where(:writer_id => writer_id).between(start_date, end_date).group(:date).order(:date).all
    counts_between(date_counts, start_date, end_date)
  end
  
  # Get the number of views for an article on each day between and including start_date and end_date.
  def self.counts_for_article_between(article_id, start_date, end_date)
    views = DailyPageView.between(start_date, end_date).joins(:article) & Article.where(:id => article_id)
    counts_between(views, start_date, end_date)
  end
    
  def self.counts_between(views, start_date, end_date)
    (start_date.to_date..end_date.to_date).map do |day| 
      view_on_day = views.find{|v| v.date == day}
      view_on_day.nil? ? 0 : view_on_day.count
    end
  end
  
  def self.article_counts_for_writer_between(writer_id, start_date, end_date, limit, offset)
    set_table_name 'daily_page_views_master'
    
    DailyPageView.
      partitioned(writer_id).
      select("article_id, title, permalink, SUM(count) as count").
      where(:writer_id => writer_id).
      between(start_date, end_date).
      joins(:article).
      group("article_id, title, permalink").
      order("count DESC").
      limit(limit).
      offset(offset)
  end

end
