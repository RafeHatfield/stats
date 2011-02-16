class PageViewsController < ApplicationController
  def create
    page_hash = {:page_id => params[:page_id], :writer_id => params[:writer_id], :page_url => params[:page_url]}
    @page = Page.find(:page_id => params[:page_id])
    if @page.blank?
      @page = Page.create(page_hash)
    end
    
    pageview_hash = {:referer_url => params[:referer_url], :page_title => params[:page_title], :cookie_id => params[:cookie_id]}
    visited_at = params[:visited_at].blank? ? Time.now : params[:visited_at]
    pageview_hash.merge!({:visited_at => visited_at })
    
    page_views_for_user = @page.page_views.find(:cookie_id => params[:cookie_id])
    last_pageview = @page_views_for_users.last
    if 30.minutes.ago > last_pageview.visited_at
      @page.page_views.create(pageview_hash)
    end
    send_file 'public/images/page_view.gif'
  end
  
  def index
    @pageviews = PageView.all
  end
  
  def show
    
  end
  
  def generate_article_view
  end
  
end