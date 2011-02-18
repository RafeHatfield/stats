class Page < Ohm::Model
  include Ohm::Boundaries
  
  attribute :writer_id
  attribute :page_title
  attribute :page_url
  attribute :tracked_page_id
  
  collection :page_views, PageView
  
  counter :total_view_count
  index :tracked_page_id
  index :writer_id
  
  def validate
    assert_present :page_url, :writer_id
    assert_present :tracked_page_id
    assert_unique :tracked_page_id
  end
  
  def insert_page_view(params)      
    page_views_for_user = self.page_views.all.find_all{|p| p.cookie_id == params[:cookie_id]}
    last_pageview_for_user = page_views_for_user.last
    if last_pageview_for_user.blank? || 30.minutes.ago > Time.parse(last_pageview_for_user.visited_at)
      pageview_hash = {:referer_url => params[:referer_url], :cookie_id => params[:cookie_id]}
      visited_at = params[:visited_at].blank? ? Time.now : params[:visited_at]
      pageview_hash.merge!({:visited_at => visited_at, :page_id => self.id})
      page_view = PageView.create(pageview_hash)
      self.page_views << page_view
      page_view
    end
  end
  
  def self.least_viewed_for(writer_id, limit)
    pages_for_writer = Page.find(:writer_id => writer_id)
    pages_for_writer.sort_by(:lifetime_view_count, :limit => limit)
  end  
  
end
