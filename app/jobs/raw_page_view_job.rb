class RawPageViewJob
  @queue = :page_view

  def self.perform(raw_page_view_data)
    # Create a new page view
    hash = ActiveSupport::JSON.decode(raw_page_view_data)
    raw_page_view = RawPageView.create(hash)
    
    article = Article.find_and_update_title_or_create({
      :suite101_article_id => raw_page_view.tracked_page_id,
      :title => raw_page_view.page_title,
      :writer_id => raw_page_view.writer_id,
      :permalink => raw_page_view.page_url
    })

    # Increment the daily page view count for this article.
    article.increment_page_view_on(raw_page_view.visited_at.to_date)
    
    # Increment the daily keyphrase view count for this article.
    engine = SearchUrlParser.get_search_engine(raw_page_view.referrer_url)
    keyphrase = SearchUrlParser.get_keywords(raw_page_view.referrer_url, engine)
    article.increment_keyphrase_view_on(raw_page_view.visited_at.to_date, keyphrase)

  end
  
end