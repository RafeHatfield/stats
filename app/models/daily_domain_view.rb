# == Schema Information
# Schema version: 20110311181219
#
# Table name: daily_domain_views
#
#  id         :integer         not null, primary key
#  date       :date
#  article_id :integer
#  domain     :string(255)
#  count      :integer
#  writer_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class DailyDomainView < ActiveRecord::Base
  belongs_to :article
  
  validates_presence_of :date, :article_id, :writer_id, :count
  
  # Get the total number of views for each domain for writer_id between start_date and end_date
  # Ordered by total count descending.
  def self.domains_with_total_counts_for_writer_between(writer_id, start_date, end_date, options={})  
    domain_counts = DailyDomainView.where(:writer_id => writer_id).between(start_date, end_date).group("domain").select("domain").order("sum_count desc")
    if options[:limit]
      domain_counts = domain_counts.limit(options[:limit])
    end
  
    domain_counts.sum("count").to_a
  end
  
  # Get the total number of views for each domain for an article between start_date and end_date
  # Ordered by total count descending.
  def self.domains_with_total_counts_for_article_between(suite101_article_id, start_date, end_date)  
    domains = DailyDomainView.between(start_date, end_date).joins(:article) & Article.where(:suite101_article_id => suite101_article_id)
    domain_counts = domains.group("domain").select("domain").order("sum_count desc")
    domain_counts.sum("count").to_a
  end
  
  # Get a hash with the total number of internal, organic, direct views for writer_id between
  # start_date and end_date
  def self.sources_with_total_counts_for_writer_between(writer_id, start_date, end_date)
    domain_counts = DailyDomainView.where(:writer_id => writer_id).between(start_date, end_date).group("domain").select("domain").order("sum_count desc").sum("count")
    
    source_counts = domain_counts.map {|domain,count| [source_from_domain(domain), count]}
    
    total_source_counts = {:internal => 0, :other => 0, :organic => 0}
    
    source_counts.each do |source_count|
      total_source_counts[source_count[0]] += source_count[1]      
    end
    
    return total_source_counts
    
  end
  
  # Get a hash with the total number of internal, organic, direct views for an article between
  # start_date and end_date
  def self.sources_with_total_counts_for_article_between(suite101_article_id, start_date, end_date)
    domains = DailyDomainView.between(start_date, end_date).joins(:article) & Article.where(:suite101_article_id => suite101_article_id)
    domain_counts = domains.group("domain").select("domain").order("sum_count desc").sum("count")
    
    source_counts = domain_counts.map {|domain,count| [source_from_domain(domain), count]}
    
    total_source_counts = {:internal => 0, :other => 0, :organic => 0}
    
    source_counts.each do |source_count|
      total_source_counts[source_count[0]] += source_count[1]      
    end
    
    return total_source_counts
    
  end
  
  
  # Domain Views on and between start_date and end_date
  def self.between(start_date, end_date)
    where(:date => start_date.to_date...(end_date.to_date + 1.day))
    # Note: With "..." range rails generates a sql where clause with 
    # date >= d1, date < d2 so we add an extra day to include today.
  end
  
  private
  
  def self.source_from_domain(domain)
    url = domain.blank? ? "" : "http://#{domain}"
    ReferrerUrl.new(url).source
  end
  
end
