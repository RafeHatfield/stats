class PageViewsController < ApplicationController
  def create
    hash = {:page_id => params[:page_id], :writer_id => params[:writer_id], :page_url => params[:page_url], :referer_url => params[:referer_url], :page_title => params[:page_title]}
    visited_at = params[:visited_at].blank? ? Time.now : params[:visited_at]
    hash.merge!({:visited_at => visited_at })
    PageView.create(hash)
    
    send_file 'public/images/page_view.gif'
  end
  
  def index
    
  end
end