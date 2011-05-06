class ArticlesController < ApplicationController
  before_filter :set_start_and_end_date
  before_filter :get_user
  
  def for_writer
    @article_counts, @number_of_articles_with_views = DailyPageView.paginated_article_counts_for_writer_between(params[:writer_id], @start_date, @end_date, params[:page])
    render :partial => 'articles', :locals => {:article_counts => @article_counts} and return
  end
      
end
