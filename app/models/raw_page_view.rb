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

require 'memcache'

class RawPageView < ActiveRecord::Base

  validate :view_must_be_unique
  validates_presence_of :page_title, :tracked_page_id, :page_url, :page_title, :writer_id, :cookie_id, :visited_at
  
  def view_must_be_unique
    
    page_view_uuid = "#{self.tracked_page_id}#{self.referrer_url}#{self.cookie_id}".hash.to_s
    
    previous_visited_at = RawPageView.uniqueness_cache.get(page_view_uuid)
    
    if previous_visited_at && visited_at - previous_visited_at <= 30.minutes
      errors.add(:base, "This view is not unique.")
    end
    
    RawPageView.uniqueness_cache.set(page_view_uuid, visited_at)
    
  end
  
  def self.uniqueness_cache
    @@uniqueness_cache ||= MemCache.new "localhost:11211"
  end
  
end
