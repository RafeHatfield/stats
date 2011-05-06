class DailyDomainView < ActiveRecord::Base
  belongs_to :article
  
  validates_presence_of :date, :article_id, :writer_id, :count
  
  scope :between, lambda {|start_date, end_date| where(:date => start_date.to_date...(end_date.to_date + 1.day)) }
            
  def self.domain_counts_for_writer_between(writer_id, start_date, end_date, options={})
    DailyDomainView.domain_count_for_writer_between(writer_id, start_date, end_date, options)
  end
  
  def self.domain_counts_for_article_between(writer_id, start_date, end_date, options={})
    DailyDomainView.domain_count_for_article_between(writer_id, start_date, end_date, options)
  end
  
  def self.source_counts_for_writer_between(writer_id, start_date, end_date)
    total_domain_counts = DailyDomainView.domain_count_for_writer_between(writer_id, start_date, end_date, options)
    source_counts = total_domain_counts.map {|domain,count| [source_from_domain(domain), count]}
    
    total_source_counts = {:internal => 0, :other => 0, :organic => 0}
    
    source_counts.each do |source_count|
      total_source_counts[source_count[0]] += source_count[1]      
    end
    
    return total_source_counts
  end
  
  def self.source_counts_for_article_between(article_id, start_date, end_date)
    total_domain_counts = DailyDomainView.domain_count_for_article_between(article_id, start_date, end_date, options)
    source_counts = total_domain_counts.map {|domain,count| [source_from_domain(domain), count]}
    
    total_source_counts = {:internal => 0, :other => 0, :organic => 0}
    
    source_counts.each do |source_count|
      total_source_counts[source_count[0]] += source_count[1]      
    end
    
    return total_source_counts
  end
            
  def self.get_counts_for_article_between(article_id, start_date, end_date)
    domain_counts = DailyDomainView.
      select("domain, SUM(count) as domain_views_count").
      where(:article_id => article_id).
      between(start_date, end_date).
      joins(:article).
      group("domain").
      order("domain_views_count desc")
    
    source_counts = domain_counts.map {|domain_count| [source_from_domain(domain_count.domain), domain_count.domain_views_count]}

    total_source_counts = {:internal => 0, :other => 0, :organic => 0}

    source_counts.each do |source_count|
      total_source_counts[source_count[0]] += source_count[1].to_i      
    end
    
    return [domain_counts, total_source_counts]
  end
        
  def self.get_counts_for_writer_between(writer_id, start_date, end_date, options={})
    
    total_domain_counts = DailyDomainView.domain_count_for_writer_between(writer_id, start_date, end_date, options)
        
    source_counts = total_domain_counts.map {|domain,count| [source_from_domain(domain), count]}
    
    total_source_counts = {:internal => 0, :other => 0, :organic => 0}
    
    source_counts.each do |source_count|
      total_source_counts[source_count[0]] += source_count[1]      
    end
    
    return [total_domain_counts.to_a, total_source_counts]
  end
  
  private
  
  def self.source_from_domain(domain)
    url = domain.blank? ? "" : "http://#{domain}"
    ReferrerUrl.new(url).source
  end
  
  def self.domain_count_for_writer_between(writer_id, start_date, end_date, options={})
    domain_counts = DailyDomainView.where(:writer_id => writer_id).between(start_date, end_date).group("domain").select("domain").order("sum_count desc")
    
    if options[:limit]
      domain_counts = domain_counts.limit(options[:limit])
    end
  
    total_domain_counts = domain_counts.sum("count")
  end
  
  def self.domain_count_for_article_between(article_id, start_date, end_date, options={})
    domain_counts = DailyDomainView.where(:article_id => article_id).between(start_date, end_date).group("domain").select("domain").order("sum_count desc")
    
    if options[:limit]
      domain_counts = domain_counts.limit(options[:limit])
    end
  
    total_domain_counts = domain_counts.sum("count")
  end
  
end
