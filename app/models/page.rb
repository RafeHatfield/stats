class Page < Ohm::Model
  include Ohm::Boundaries
  
  attribute :writer_id
  attribute :page_title
  attribute :page_url
  attribute :page_id
  
  collection :page_views, PageView
  
  counter :lifetime_view_count
  index :page_id
  
  def validate
    assert_present :page_url, :writer_id
    assert_present :page_id
    assert_unique :page_id
  end
  
  def insert_page_view(params)    
    page_views_for_user = self.page_views.all.find_all{|p| p.cookie_id == params[:cookie_id]}
    last_pageview_for_user = page_views_for_user.last
    if last_pageview_for_user.blank? || 30.minutes.ago > Time.parse(last_pageview_for_user.visited_at)
      pageview_hash = {:referer_url => params[:referer_url], :cookie_id => params[:cookie_id]}
      visited_at = params[:visited_at].blank? ? Time.now : params[:visited_at]
      pageview_hash.merge!({:visited_at => visited_at, :page_id => self.id })
      self.page_views << PageView.create(pageview_hash)
    end
  end
  
end