class RawPageViewJob
  @queue = :page_view

  def self.perform(raw_page_view_data)
    # Create a new page view
    hash = ActiveSupport::JSON.decode(raw_page_view_data)
    RawPageView.create(hash)
    
    ## flow for job
    # insert into raw_page_view table

    # update articles table
    # if not article_id in articles table
    # => insert into articles table
    # else
    # => if title doesn't match, update it

    # update page_views table
    # check for a row on this day for this article
    # if it exists
    # => increment count
    # else 
    # => create with 1 count
    # (can do this: try updating day/article row, if updated, ok. else insert)
    
    # parse the referrer url to get an array of keywords, and a domain
    
    # update the keywords table 
    # 
    

    
    
    
    
  end
  
end