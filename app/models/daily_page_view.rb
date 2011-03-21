# == Schema Information
# Schema version: 20110228215559
#
# Table name: daily_page_views
#
#  id         :integer         not null, primary key
#  date       :date
#  article_id :integer
#  count      :integer
#  writer_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class DailyPageView < ActiveRecord::Base

  belongs_to :article

  validates_presence_of :date, :article_id, :count, :writer_id
  
  # Get the number of views for all articles for writer_id on each day between and including start_date and end_date.
  def self.counts_for_writer_between(writer_id, start_date, end_date)
    views = DailyPageView.where(:writer_id => writer_id).between(start_date, end_date).all
    counts_between(views, start_date, end_date)
  end
  
  # Get the number of views for an article on each day between and including start_date and end_date.
  def self.counts_for_article_between(article_id, start_date, end_date)
    views = DailyPageView.between(start_date, end_date).joins(:article) & Article.where(:id => article_id)
    counts_between(views, start_date, end_date)
  end
    
  def self.counts_between(views, start_date, end_date)
    (start_date.to_date..end_date.to_date).map do |day| 
      views_on_day = views.find_all{|v| v.date == day}
      views_on_day.any? ? views_on_day.sum{|v| v.count} : 0
    end
  end
    
  # Page Views on and between start_date and end_date
  def self.between(start_date, end_date)
    where(:date => start_date.to_date...(end_date.to_date + 1.day))
    # Note: With "..." range rails generates a sql where clause with 
    # date >= d1, date < d2 so we add an extra day to include today.
  end

end
