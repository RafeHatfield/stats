class PageViewsController < ApplicationController
  def create
    page_hash = {:page_id => params[:page_id], :writer_id => params[:writer_id], :page_url => params[:page_url]}
    @page = Page.find(:page_id => params[:page_id]).andand.first
    if @page.blank?
      @page = Page.create(page_hash)
    end    
    page_views_for_user = @page.page_views.all.find_all{|p| p.cookie_id == params[:cookie_id]}
    last_pageview_for_user = page_views_for_user.last
    if last_pageview_for_user.blank? || 30.minutes.ago > Time.parse(last_pageview_for_user.visited_at)
      pageview_hash = {:referer_url => params[:referer_url], :cookie_id => params[:cookie_id]}
      visited_at = params[:visited_at].blank? ? Time.now : params[:visited_at]
      pageview_hash.merge!({:visited_at => visited_at, :page_id => @page.id })
      @page.page_views << PageView.create(pageview_hash)
    end
    
    send_file 'public/images/page_view.gif'
  end
  
  def index
    @pageviews = PageView.all
  end
  
  def show
    
  end
end