class PageViewsController < ApplicationController
  def create
    params.merge!({:visited_at => Time.now})
    PageView.create(params)
    
    send_file 'public/images/page_view.gif'
  end
end