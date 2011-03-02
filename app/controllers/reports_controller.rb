class ReportsController < ApplicationController
  
  def index
    # Check if the id and key match
    @suite101_member_id = params[:id]
    @key = params[:key]
    
    if @suite101_member_id != Base64.decode64(params[:key])
      render :file => "/public/404.html", :status => 404
    end

    if params[:start_date]
      @start_date = Date.civil(params[:start_date]["year"].to_i, params[:start_date]["month"].to_i, params[:start_date]["day"].to_i)
    else
      @start_date = 7.days.ago.to_date
    end
    
    if params[:end_date]
      @end_date = Date.civil(params[:end_date]["year"].to_i, params[:end_date]["month"].to_i, params[:end_date]["day"].to_i)
    else
      @end_date = Date.today
    end
    
    @views = DailyPageView.views_for_writer_between(@suite101_member_id, @start_date, @end_date)
        
    @view_counts = (@start_date..@end_date).map do |day| 
      view = @views.detect{|v| v.date == day}
      (view && view.count) || 0
    end
    
    @total_views = @views.sum{|v| v.count}

  end
  
  def test_index
    # Generate a key for the user and redirect to their dashbaord
    
    suite101_member_id = params[:id]
    key = Base64.encode64(suite101_member_id)
    
    redirect_to dashboard_url(suite101_member_id, key)
    
  end
  
end
