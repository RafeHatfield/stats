class RawPageViewJob
  @queue = :page_view

  def self.perform(raw_page_view_data)
    hash = ActiveSupport::JSON.decode(raw_page_view_data)
    raw_page_view = RawPageView.new(hash)

    if raw_page_view.unique?
      raw_page_view.save!
      process_raw_page_view(raw_page_view)
    end
  end
  
  def self.process_raw_page_view(raw_page_view)
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
    if keyphrase
      article.increment_keyphrase_view_on(raw_page_view.date.to_date, keyphrase)
    end
  end  
end