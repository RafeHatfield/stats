# == Schema Information
# Schema version: 20110303185633
#
# Table name: daily_keyphrase_views
#
#  id         :integer         not null, primary key
#  date       :date
#  article_id :integer
#  keyphrase  :string(255)
#  count      :integer
#  writer_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class DailyKeyphraseView < ActiveRecord::Base
  belongs_to :article
  
  validates_presence_of :date, :article_id, :writer_id, :count
  
  # Get the total number of views for each keyphrase for writer_id between start_date and end_date
  def self.total_keyphrase_counts_for_writer_between(writer_id, start_date, end_date)
    
    start_date = start_date.to_date
    end_date = end_date.to_date
    
    keyphrase_counts = DailyKeyphraseView.where(:writer_id => writer_id, :date => start_date...end_date + 1.day).group("keyphrase").select("keyphrase, sum(count) as count")
    
    keyphrase_counts.map {|k| [k.keyphrase, k.count]}
  end
end
