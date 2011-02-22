class MembersController < ApplicationController
  
  def index
    @total_page_views = Page.total_page_views_for(params[:id])
  end
  
end
