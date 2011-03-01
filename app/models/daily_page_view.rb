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
  
  # Get the page views for writer_id between and including start_date and end_date
  def self.views_for_writer_between(writer_id, start_date, end_date)
    
    start_date = start_date.to_date
    end_date = end_date.to_date
    
    DailyPageView.where(:writer_id => writer_id, :date => start_date...end_date + 1.day).all
    # Note: With "..." range rails generates a sql where clause with date >= d1, date < d2 so we add an extra day to include today
  end
    

end
