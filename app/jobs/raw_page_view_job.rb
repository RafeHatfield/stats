class RawPageViewJob
  @queue = :page_view

  def self.perform(raw_page_view_data)
    hash = ActiveSupport::JSON.decode(raw_page_view_data)
    select_shard(hash['permalink']) do      
      view = RawPageView.new(hash)
      begin
        process_raw_page_view(view) if view.save!
      rescue ActiveRecord::RecordNotSaved
        # Only throw validation errors.
      end
    end
  end

private

  def self.select_shard(url)
    if SHARDING_ENABLED && url.present?
      domain_extension = Addressable::URI.parse(url).host.split('.').last
      Octopus.using(domain_extension.to_sym) { yield }
    else
      yield
    end
  end
  
  def self.process_raw_page_view(raw_page_view)   
    article = Article.find_and_update_title_or_create({
      :suite101_article_id => raw_page_view.suite101_article_id,
      :title => raw_page_view.title,
      :writer_id => raw_page_view.writer_id,
      :permalink => raw_page_view.permalink
    })

    referrer_url = ReferrerUrl.new(raw_page_view.referrer_url)

    article.increment_page_view_on(raw_page_view.date.to_date)

    if referrer_url.keyphrase
      article.increment_keyphrase_view_on(raw_page_view.date, referrer_url.keyphrase)
    end

    article.increment_domain_view_on(raw_page_view.date, referrer_url.domain)
  end  
  
end