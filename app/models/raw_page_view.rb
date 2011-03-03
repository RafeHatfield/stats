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

require 'memcache'

class RawPageView < ActiveRecord::Base

  validate :view_must_be_unique
  validates_presence_of :title, :suite101_article_id, :permalink, :title, :writer_id, :cookie_id, :date
  
  after_validation :debug_validation_errors
  
  def view_must_be_unique
    
    page_view_uuid = "#{self.suite101_article_id}#{self.referrer_url}#{self.cookie_id}".hash.to_s
    
    previous_date = RawPageView.uniqueness_cache.get(page_view_uuid)
    
    if previous_date && self.date - previous_date <= 30.minutes
      errors.add(:base, "This view is not unique.")
    end
    
    RawPageView.uniqueness_cache.set(page_view_uuid, self.date)
    
  end
  
  def self.uniqueness_cache
    @@uniqueness_cache ||= MemCache.new ENV["MEMCACHED_CONNECTION_PATH"]
  end
  
  def debug_validation_errors
    if !self.errors.empty?
      # logger.debug("--Validations failed for RawPageView:")
      #       logger.debug(errors.inspect)
      
      ## TODO: Make this only log in the development environment so that the log file doesn't overflow.
      logger.info("--Validations failed for RawPageView:")
      logger.info(errors.inspect)           
    end
  end
  
end
