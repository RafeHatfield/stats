module Factory
  
  def params_for_page
    {
      :page_title=>"Chocolate has an Expiration Date", 
      :page_url=>"http://www.suite101.com/content/chocolate-has-an-expiration-date-a347637", 
      :tracked_page_id=>rand(100000).to_s, 
      :writer_id=>rand(100000).to_s
    }
  end
  
  def create_page(hash={})
    page_hash = params_for_page.merge!(hash)
    page = Page.find(:tracked_page_id => page_hash[:tracked_page_id]).first
    if page.blank?
      page = Page.create(page_hash)
    end
    page
  end
  
  # Note that we manually need to set page_id for a page_view
  # since the association doesn't happen properly with OHM.
  def params_for_page_view
    {
      :visited_at=>Time.now, 
      :referer_url=>'http://google.com', 
      :cookie_id => rand(100000)
    }
  end
  
  def create_page_view(hash={})
    page_view_hash = params_for_page_view.merge(hash)
    PageView.create(page_view_hash)
  end
end