# == Schema Information
# Schema version: 20110222190224
#
# Table name: raw_page_views
#
#  id              :integer         not null, primary key
#  tracked_page_id :integer
#  page_url        :string(255)
#  page_title      :string(255)
#  writer_id       :integer
#  referrer_url    :string(255)
#  cookie_id       :string(255)
#  visited_at      :datetime
#

class RawPageView < ActiveRecord::Base

  validate :view_must_be_unique
  validates_presence_of :page_title, :tracked_page_id, :page_url, :page_title, :writer_id, :referrer_url, :cookie_id, :visited_at

  
  @@uniqueness_hash = {}

  
  def view_must_be_unique
    
    page_view_uuid = "#{tracked_page_id}#{referrer_url}#{cookie_id}".hash.to_s

    if @@uniqueness_hash[page_view_uuid] && visited_at - @@uniqueness_hash[page_view_uuid] <= 30.minutes
      errors.add(:base, "This view is not unique.")
    end
    
    @@uniqueness_hash[page_view_uuid] = visited_at
    
  end
  
end
