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

    # Get a list of article titles and view counts for this range for the writer.    
    @article_counts = Article.title_counts_for_writer_between(@suite101_member_id, @start_date, @end_date)
    
    # Sort articles by the view count descending
    @sorted_article_counts = @article_counts.sort_by {|i| i[1]*-1}

  end
  
  def test_index
    # Generate a key for the user and redirect to their dashbaord
    
    suite101_member_id = params[:id]
    key = Base64.encode64(suite101_member_id)
    
    redirect_to dashboard_url(suite101_member_id, key)
    
  end
  
end
