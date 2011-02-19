class PageViewsController < ApplicationController
  def create
    @page = Page.find_or_create_by_tracked_page_id(params[:tracked_page_id], {
      :tracked_page_id => params[:tracked_page_id],
      :writer_id => params[:writer_id],
      :page_url => params[:page_url]
    })
    
    @page.insert_page_view({
      :visited_at => params[:visited_at],
      :referer_url => params[:referer_url],
      :cookie_id => params[:cookie_id]
    })
    
    send_file 'public/images/page_view.gif'
  end
  
  def index
    @pageviews = PageView.all
  end
  
  def show
    
  end

end