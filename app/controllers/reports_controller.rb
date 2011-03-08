class ReportsController < ApplicationController
  
  before_filter :verify_key, :only => [:index, :article_views_csv, :weekly_page_view_graph, :monthly_page_view_graph, :twelve_week_page_view_graph]
  
  def index
    @start_date = get_selected_date(params[:start_date], 7.days.ago.to_date)
    @end_date = get_selected_date(params[:end_date], Date.today)

    @view_counts = DailyPageView.view_counts_for_writer_between(@user[:id], @start_date, @end_date)
    @total_view_count = @view_counts.sum

    # Get a list of [titles, count] for this range for the writer, sorted by view count descending
    article_counts = Article.total_title_counts_for_writer_between(@user[:id], @start_date, @end_date)
    @article_counts = article_counts.sort_by {|i| i[1]*-1}
    
    keyphrase_counts = DailyKeyphraseView.total_keyphrase_counts_for_writer_between(@user[:id], @start_date, @end_date)
    @keyphrase_counts = keyphrase_counts.sort_by {|i| i[1]*-1}

  end
  
  def weekly_page_view_graph
    # We subtract 1 day to use Sunday as the beginning of the week. 
    @this_start_date = Date.today.at_beginning_of_week - 1.day
    @this_end_date = Date.today.at_end_of_week - 1.day
    
    @last_start_date = @this_start_date - 1.week
    @last_end_date = @this_start_date - 1.day

    @view_counts_this_week = DailyPageView.view_counts_for_writer_between(@user[:id], @this_start_date, @this_end_date)
    @view_counts_last_week = DailyPageView.view_counts_for_writer_between(@user[:id], @last_start_date, @last_end_date) 
    
    render :layout => false   
  end
  
  def monthly_page_view_graph
    @this_start_date = Date.today.at_beginning_of_month
    @this_end_date = Date.today
    
    @last_start_date = 1.month.ago.at_beginning_of_month.to_date
    @last_end_date = 1.month.ago.at_end_of_month.to_date

    @view_counts_this_month = DailyPageView.view_counts_for_writer_between(@user[:id], @this_start_date, @this_end_date)
    @view_counts_last_month = DailyPageView.view_counts_for_writer_between(@user[:id], @last_start_date, @last_end_date)
    
    # Nil pad the arrays so that they contain the same number of days
    while @view_counts_this_month.count < 31
      @view_counts_this_month << nil
    end
    
    while @view_counts_last_month.count < 31
      @view_counts_last_month << nil
    end

    render :layout => false
  end
  
  def twelve_week_page_view_graph
    @start_date = Date.today.at_beginning_of_week - 11.weeks
    @end_date = Date.today

    view_counts = DailyPageView.view_counts_for_writer_between(@user[:id], @start_date, @end_date)
    
    @view_counts_by_week = []
    view_counts.in_groups_of(7, false) do |week_counts|
      @view_counts_by_week << week_counts.sum
    end
    
    render :layout => false       
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
