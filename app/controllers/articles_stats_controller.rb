class ArticleStatsController < ApplicationController
  before_filter :get_user
  before_filter :set_start_and_end_date
  
  def index
    @article_counts = Article.paginated_pageviews_for_writer_between(@user[:id], @start_date, @end_date, params[:page])
    render :partial => 'article_stats/articles_stats', :locals => {:articles_stats => @article_counts} and return
  end
  
  def keyphrases
    
  end
end
