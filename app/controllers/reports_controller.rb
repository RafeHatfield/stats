class ReportsController < ApplicationController
  
  def index
    # Check if the id and key match
    @suite101_member_id = params[:id]
    @key = params[:key]
    
    if @suite101_member_id != Base64.decode64(params[:key])
      render :file => "/public/404.html", :status => 404
    end

    params[:start_days_ago] ||= "90"
    @start_date = params[:start_days_ago].to_i.days.ago
    @end_date = Date.today

    @views = DailyPageView.views_for_writer_between(@suite101_member_id, @start_date, @end_date)
    
    @total_views = @views.sum{|v| v.count}

  end
  
  def test_index
    # Generate a key for the user and redirect to their dashbaord
    
    suite101_member_id = params[:id]
    key = Base64.encode64(suite101_member_id)
    
    redirect_to dashboard_url(suite101_member_id, key)
    
  end
  
end
