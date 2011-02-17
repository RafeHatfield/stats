module Factory
  def create_page(hash={})
    page_hash ={:page_title=>"Chocolate has an Expiration Date", :page_url=>"http://www.suite101.com/content/chocolate-has-an-expiration-date-a347637", :page_id=>'12345', :writer_id=>"731923"}
    page_hash.merge!(hash)
    Page.create(page_hash)
  end
  
  def create_page_view(hash={})
    page_view_hash ={:visited_at=>Time.now, :referer_url=>'http://google.com', :cookie_id => '223445'}
    page_view_hash.merge!(hash)
    PageView.create(page_view_hash)
  end
end