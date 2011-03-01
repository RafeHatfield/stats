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

end
