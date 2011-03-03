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
  
 
end
