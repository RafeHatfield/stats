class ArticleStatsController < ApplicationController
  before_filter :get_user
  before_filter :set_start_and_end_date
  
  def index
    @article_counts = Article.with_total_counts_for_writer_between(@user[:id], @start_date, @end_date).page(params[:page]).all
    @article_counts.instance_eval <<-EVAL
      def current_page
        #{params[:page] || 1}
      end
      def num_pages
        count
      end
      def limit_value                                                                               
        20
      end
    EVAL
    render :partial => 'articles_stats/articles_stats', :locals => {:articles_stats => @article_counts} and return
  end
end
