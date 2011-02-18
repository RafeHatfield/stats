class PageViewsController < ApplicationController
  def create
    page_hash = {:tracked_page_id => params[:tracked_page_id], :writer_id => params[:writer_id], :page_url => params[:page_url]}
    @page = Page.find(:tracked_page_id => params[:tracked_page_id]).andand.first
    if @page.blank?
      @page = Page.create(page_hash)
    end
    @page.insert_page_view(params)
    
    send_file 'public/images/page_view.gif'
  end
  
  def index
    @pageviews = PageView.all
  end
  
  def show
    
  end

end