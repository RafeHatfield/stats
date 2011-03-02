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

    article.increment_page_view_on(:date => raw_page_view.visited_at.to_date)
    # (can do this: try updating day/article row, if updated, ok. else insert)
        
    # parse the referrer url to get an array of keywords, and a domain
    # update the keywords table 
    # 
  end
  
end