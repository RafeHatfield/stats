class RawPageViewJob
  @queue = :page_view

  def self.perform(raw_page_view_data)
    # Create a new page view
    begin   
      hash = ActiveSupport::JSON.decode(raw_page_view_data)
    
      raw_page_view = RawPageView.new(hash)
    
      if raw_page_view.unique?
        raw_page_view.save!

        article = Article.find_and_update_title_or_create({
          :suite101_article_id => raw_page_view.suite101_article_id,
          :title => raw_page_view.title,
          :writer_id => raw_page_view.writer_id,
          :permalink => raw_page_view.permalink
        })

        # Increment the daily page view count for this article.
        article.increment_page_view_on(raw_page_view.date.to_date)
    
        # Increment the daily keyphrase view count for this article.
        engine = SearchUrlParser.get_search_engine(raw_page_view.referrer_url)
        keyphrase = SearchUrlParser.get_keywords(raw_page_view.referrer_url, engine)
        article.increment_keyphrase_view_on(raw_page_view.date.to_date, keyphrase)
      end
      
    rescue => e
      Rails.logger.info("Exception happened #{e}")
      raise "#{e}"
    end
  end
  
end