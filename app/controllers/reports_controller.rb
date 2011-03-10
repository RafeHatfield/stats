class ReportsController < ApplicationController

  before_filter :verify_key, :except => [:test_dashboard]
  
  # Ensure that the supplied id and key match our encoding.
  # Setup the @user object with authentication info.
  def verify_key
    @user = {:id => params[:id], :key => params[:key]}
    if @user[:id] != Base64.decode64(@user[:key])
      render :file => "/public/404.html", :status => 404
      return false
    end
  end
  
  # Show the user's dashboard.
  def dashboard
    @start_date = get_selected_date(params[:start_date], 7.days.ago.to_date)
    @end_date = get_selected_date(params[:end_date], Date.today)

    @view_counts = DailyPageView.counts_for_writer_between(@user[:id], @start_date, @end_date)
    @total_view_count = @view_counts.sum
    @article_counts = Article.with_total_counts_for_writer_between(@user[:id], @start_date, @end_date)
    @keyphrase_counts = DailyKeyphraseView.keyphrases_with_total_counts_for_writer_between(@user[:id], @start_date, @end_date)
    @domain_counts = DailyDomainView.domains_with_total_counts_for_writer_between(@user[:id], @start_date, @end_date)
    @source_counts = DailyDomainView.sources_with_total_counts_for_writer_between(@user[:id], @start_date, @end_date)
    
  end
  
  # Generate a key for the user and redirect to their dashbaord
  def test_dashboard
    redirect_to dashboard_url(params[:id], Base64.encode64(params[:id]))    
  end
  
  # Render javascript which will update the #total_page_views element with the lifetime page views of this user.
  def update_total_page_views
    total_page_views = DailyPageView.counts_for_writer_between(@user[:id], 90.days.ago.to_date, Date.today).sum
    render :js => "$(function(){$('#total_page_views').text(#{total_page_views});});"
  end

  # Redirect to a google sparkline showing the cumulative percentage of page views over the last 12 weeks.
  def page_view_sparkline
    view_counts = DailyPageView.counts_for_writer_between(@user[:id], Date.today.at_beginning_of_week - 11.weeks, Date.today)
    
    view_counts_by_week = []
    view_counts.in_groups_of(7, false) do |week_counts|
      view_counts_by_week << week_counts.sum
    end

    total_view_counts = view_counts_by_week.sum    
    sum = 0
    cumulative_view_counts = view_counts_by_week.map {|count| sum += count}
    cumulative_percentages = cumulative_view_counts.map {|count| (100 * count / total_view_counts).to_i}

    redirect_to "http://chart.apis.google.com/chart?cht=lc&chs=50x16&chco=369E00&chd=t:#{cumulative_percentages.join(',')}&chf=bg,s,FFFFFF00&chls=2,1,0"
  end
  
  # Render a chart showing the view counts for the writer in the last 12 weeks,
  # summed by week.
  def twelve_week_page_view_graph
    view_counts = DailyPageView.counts_for_writer_between(@user[:id], Date.today.at_beginning_of_week - 11.weeks, Date.today)
    
    @view_counts_by_week = []
    view_counts.in_groups_of(7, false) do |week_counts|
      @view_counts_by_week << week_counts.sum
    end
    
    render :layout => false       
  end
  
  # Render a chart showing this week vs last week's page views.
  def weekly_page_view_graph
    @this_start_date = Date.today.at_beginning_of_week - 1.day
    @this_end_date = Date.today.at_end_of_week - 1.day
    @last_start_date = @this_start_date - 1.week
    @last_end_date = @this_start_date - 1.day
    # NOTE: We subtract 1 day to use Sunday as the beginning of the week,
    # since this is how mysuite does it currently.

    @view_counts_this_week = DailyPageView.counts_for_writer_between(@user[:id], @this_start_date, @this_end_date)
    @view_counts_last_week = DailyPageView.counts_for_writer_between(@user[:id], @last_start_date, @last_end_date) 
    
    render :layout => false   
  end
  
  # Render a chart showing this month vs last month's page views.
  def monthly_page_view_graph
    @this_start_date = Date.today.at_beginning_of_month
    @this_end_date = Date.today
    @last_start_date = 1.month.ago.at_beginning_of_month.to_date
    @last_end_date = 1.month.ago.at_end_of_month.to_date

    @view_counts_this_month = DailyPageView.counts_for_writer_between(@user[:id], @this_start_date, @this_end_date)
    @view_counts_last_month = DailyPageView.counts_for_writer_between(@user[:id], @last_start_date, @last_end_date)
    
    # Nil pad the arrays so that they contain the same number of days,
    # so that the axes display properly.
    while @view_counts_this_month.count < 31
      @view_counts_this_month << nil
    end
    while @view_counts_last_month.count < 31
      @view_counts_last_month << nil
    end

    render :layout => false
  end
  
  def article_views_csv
    
    @article_counts = Article.with_total_counts_for_writer_between(@user[:id], Date.yesterday, Date.yesterday)
    
    csv_string = FasterCSV.generate do |csv|
      csv << ["Title", "Views Yesterday"]
      @article_counts.each do |article_count|
        csv << [article_count[:title], article_count[:count]]
      end
    end

    send_data csv_string,
              :type => 'text/csv; charset=iso-8859-1; header=present',
              :disposition => "attachment; filename=article_counts.csv"
    
  end

  private
  
  # Parse the date from a rails select_date tag.
  def get_selected_date(date_hash, default)
    if date_hash
      Date.civil(date_hash["year"].to_i, date_hash["month"].to_i, date_hash["day"].to_i)
    else
      default
    end
  end
  
end
