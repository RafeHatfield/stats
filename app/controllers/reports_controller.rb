class ReportsController < ApplicationController
  
  before_filter :verify_key, :only => [:index, :article_views_csv]
  
  def index
    @start_date = get_selected_date(params[:start_date], 7.days.ago.to_date)
    @end_date = get_selected_date(params[:end_date], Date.today)
    
    @views = DailyPageView.views_for_writer_between(@user[:id], @start_date, @end_date)
    
    @view_counts = (@start_date..@end_date).map do |day| 
      views_on_day = @views.find_all{|v| v.date == day}
      views_on_day.any? ? views_on_day.sum{|v| v.count} : 0
    end
    
    @total_views = @views.sum{|v| v.count}

    # Get a list of article titles and view counts for this range for the writer.    
    @article_counts = Article.title_counts_for_writer_between(@user[:id], @start_date, @end_date)
    
    # Sort articles by the view count descending
    @sorted_article_counts = @article_counts.sort_by {|i| i[1]*-1}

  end
  
  def article_views_csv
    
    @article_counts = Article.title_counts_for_writer_between(@user[:id], Date.yesterday, Date.yesterday)
    
    csv_string = FasterCSV.generate do |csv|
      csv << ["Title", "Views Yesterday"]
      @article_counts.each do |article_count|
        csv << [article_count[0], article_count[1]]
      end
    end

    # send it to the browsah
    send_data csv_string,
              :type => 'text/csv; charset=iso-8859-1; header=present',
              :disposition => "attachment; filename=article_counts.csv"
    
    
  end
  
  def test_index
    # Generate a key for the user and redirect to their dashbaord
    redirect_to dashboard_url(params[:id], Base64.encode64(params[:id]))    
  end
  
  def verify_key
    @user = {:id => params[:id], :key => params[:key]}
    
    if @user[:id] != Base64.decode64(@user[:key])
      render :file => "/public/404.html", :status => 404
      return false
    end
  end
  
  private
  
  def get_selected_date(date_hash, default)
    if date_hash
      Date.civil(date_hash["year"].to_i, date_hash["month"].to_i, date_hash["day"].to_i)
    else
      default
    end
  end
  

  
end
