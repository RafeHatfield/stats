class RawPageViewJob
  @queue = :page_view

  def self.perform(raw_page_view_data)
    hash = ActiveSupport::JSON.decode(raw_page_view_data)
      
    select_shard(hash['permalink']) do      
      view = RawPageView.new(hash)
      begin
        view.save!
        process_raw_page_view(view)
      rescue ActiveRecord::RecordNotSaved
        # Only throw validation errors.
      end
    end
  end

private

  def self.domain_extension(url)
    extension = Addressable::URI.parse(url).host.split('.').last.to_sym
    unless [:com, :de, :net, :fr].include?(extension)
      raise "Invalid domain extension: #{extension}."
    end
    return extension
  end

  def self.select_shard(url)
    if SHARDING_ENABLED && url.present?
      Octopus.using(domain_extension(url)) { yield }
    else
      yield
    end
  end
  
  def self.set_timezone(url)
    extension_to_timezone_map = {
      :com => "Pacific Time (US & Canada)",
      :de => "Berlin",
      :net => "Madrid",
      :fr => "Paris"
    }
    Time.zone = ActiveSupport::TimeZone[extension_to_timezone_map[domain_extension(url)]]
  end
  
  def self.process_raw_page_view(raw_page_view)   
    
    set_timezone(raw_page_view.permalink)
    
    article = Article.find_and_update_title_or_create({
      :id => raw_page_view.article_id,
      :title => raw_page_view.title,
      :writer_id => raw_page_view.writer_id,
      :permalink => raw_page_view.permalink
    })

    referrer_url = ReferrerUrl.new(raw_page_view.referrer_url)

    article.increment_page_view_on(Time.zone.utc_to_local(raw_page_view.date.getutc))

    if referrer_url.keyphrase
      article.increment_keyphrase_view_on(Time.zone.utc_to_local(raw_page_view.date.getutc), referrer_url.keyphrase)
    end

    article.increment_domain_view_on(Time.zone.utc_to_local(raw_page_view.date.getutc), referrer_url.domain)
  end  
  
end