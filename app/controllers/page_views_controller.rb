class PageViewsController < ApplicationController
  def create
    page_hash = {:page_id => params[:page_id], :writer_id => params[:writer_id], :page_url => params[:page_url]}
    @page = Page.find(:page_id => params[:page_id]).andand.first
    if @page.blank?
      @page = Page.create(page_hash)
    end
    @page.insert_page_views(params)
    
    send_file 'public/images/page_view.gif'
  end
  
  def index
    @pageviews = PageView.all
  end
  
  def show
    
  end
end