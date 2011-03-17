# == Schema Information
# Schema version: 20110311181219
#
# Table name: raw_page_views
#
#  id                  :integer         not null, primary key
#  suite101_article_id :integer
#  permalink           :string(255)
#  title               :string(255)
#  writer_id           :integer
#  referrer_url        :string(1000)
#  cookie_id           :string(255)
#  date                :datetime
#

class RawPageView < ActiveRecord::Base
  validates_presence_of :title, :suite101_article_id, :permalink, :title, :writer_id, :cookie_id, :date
  validates_numericality_of :suite101_article_id, :writer_id, :only_integer => true
  validate :require_reasonable_date
  validate :require_referrer_url_to_be_a_parseable_url_or_empty
  validates_length_of :permalink, :in => 3..250
  validates_length_of :title, :in => 3..250
  validates_length_of :cookie_id, :in => 3..250
  validates_length_of :referrer_url, :maximum => 950
  
  before_validation do |v|  
    # Clean the referrer_url
    # Replace spaces (w/ may be between keywords) with pluses.
    v.referrer_url = v.referrer_url.respond_to?(:gsub) ? v.referrer_url.gsub(' ', '+') : ""
    
    # Make the cookie unique if it is nil.
    v.cookie_id ||= "#{1000 + rand(1000000)}"
  end
  
  before_save do |v|
    # Determine if this view was unique.
    is_unique = unique?
    
    # Enter/update this view in the uniqueness cache.
    RawPageView.uniqueness_cache.set(unique_identifier, self.date)
    
    # Only save if this view was unique.
    return is_unique
  end

  private
  
  def unique?    
    # Get the last similar view from the uniqueness cache.  
    previous_date = RawPageView.uniqueness_cache.get(unique_identifier)
    
    # If there wasn't a previous entry, or the previous entry was more than 30 minutes ago
    # return true.
    return !previous_date || self.date - previous_date > 30.minutes
  end

  def unique_identifier
    @unique_identifier ||= "#{self.suite101_article_id}#{self.referrer_url}#{self.cookie_id}".hash.to_s
  end
  
  def self.uniqueness_cache
    @@uniqueness_cache ||= MemCache.new ENV["MEMCACHED_CONNECTION_PATH"]
  end
  
  def require_reasonable_date
    begin
      if self.date.year < 2000 || self.date.year > 2050
        errors.add(:date, "must have a year between 2000 and 2050")
      end
    rescue
      errors.add(:date, "cannot be parsed as a date.")
    end
  end
  
  def require_referrer_url_to_be_a_parseable_url_or_empty
    if self.referrer_url != ""
      if self.referrer_url.nil?
        errors.add(:referrer_url, "was nil.")
      end
      begin
        uri = URI.parse(self.referrer_url)
        if uri.class != URI::HTTP
          errors.add(:referrer_url, "was not an http url. It is: #{self.referrer_url}.")
        end
      rescue URI::InvalidURIError
        errors.add(:referrer_url, "was not parseable. It is: #{self.referrer_url}.")
      end
    end
  end

  
end
