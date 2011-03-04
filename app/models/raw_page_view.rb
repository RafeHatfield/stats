# == Schema Information
# Schema version: 20110303215305
#
# Table name: raw_page_views
#
#  id                  :integer         not null, primary key
#  suite101_article_id :integer
#  permalink           :string(255)
#  title               :string(255)
#  writer_id           :integer
#  referrer_url        :string(255)
#  cookie_id           :string(255)
#  date                :datetime
#
class RawPageView < ActiveRecord::Base
  validates_presence_of :title, :suite101_article_id, :permalink, :title, :writer_id, :cookie_id, :date
  validates_numericality_of :suite101_article_id, :writer_id, :only_integer => true
  
  # Return true if this view is considered unique.
  # Enter/update this view in the uniqueness Cache.
  def unique?    
    # Get the last similar view from the uniqueness cache.
    previous_date = RawPageView.uniqueness_cache.get(unique_identifier)
    
    # Put this view into the uniqueness cache.
    insert_into_uniqueness_cache
    
    # If there wasn't a previous entry, or the previous entry was more than 30 minutes ago
    # return true.
    return !previous_date || self.date - previous_date > 30.minutes
  end
  
  def self.uniqueness_cache
    @@uniqueness_cache ||= MemCache.new ENV["MEMCACHED_CONNECTION_PATH"]
  end
  
  def insert_into_uniqueness_cache
    RawPageView.uniqueness_cache.set(unique_identifier, self.date)
  end
  
  private
  
  def unique_identifier
    "#{self.suite101_article_id}#{self.referrer_url}#{self.cookie_id}".hash.to_s
  end
  
end
