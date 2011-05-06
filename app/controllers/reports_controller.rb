class ReportsController < ApplicationController
  before_filter :get_user, :except => [:test_dashboard, :test_article_dashboard]
  before_filter :set_start_and_end_date, :only => [:dashboard, :article_dashboard, :article_views_csv]
  
  # Show the writer's dashboard.
  def dashboard
    
    @view_counts = DailyPageView.counts_for_writer_between(@user[:id], @start_date, @end_date)
    @total_view_count = @view_counts.sum
    
    page = params[:page] || 1     

    @article_counts, @number_of_articles_with_views = DailyPageView.paginated_pageviews_for_writer_between(@user[:id], @start_date, @end_date, page)
      
    @domain_counts, @source_counts = DailyDomainView.get_counts_for_writer_between(@user[:id], @start_date, @end_date)
        
    @source_counts = calibrated_count(@source_counts, @total_view_count)
  end
  
  # Generate a key for the user and redirect to their dashbaord
  def test_dashboard
    redirect_to dashboard_url(params[:writer_id].to_i.alphadecimal)    
  end
    
  # Dashboard for a specific article.
  def article_dashboard
    @article = Article.find(params[:article_id])
    page = params[:page] || 1
    
    @view_counts = @article.page_views_count_between(@start_date, @end_date)
    @total_view_count = @view_counts.sum
    
    @domain_counts, @source_counts = @article.domain_views_counts_between(@start_date, @end_date)
    
    @source_counts = calibrated_count(@source_counts, @view_counts.sum)
  end
  
  # Generate a key for the user and redirect to their article dashbaord
  def test_article_dashboard
    key = params[:writer_id].to_i.alphadecimal
    redirect_to article_dashboard_url(key, params[:article_id])
  end
      
  def article_views_csv
    @article_counts = DailyPageView.with_total_counts_for_writer_between(@user[:id], @start_date, @end_date)
    
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
  
  # this method is required since there is a discrepancy between daily page views count and daily domain views count
  # This method is a hack to remove the discrepeancy
  def calibrated_count(source_counts, daily_page_views_count)
    internal_and_organic_count = source_counts[:internal] + source_counts[:organic]
    other_count = daily_page_views_count - internal_and_organic_count
    source_counts[:other] = other_count
    source_counts
  end
    
end
