class KeyphrasesController < ApplicationController
  before_filter :set_start_and_end_date
  
  def index
    @article_id = params[:suite101_article_id]
    page = params[:page] || 1
    
    @keyphrase_counts = DailyKeyphraseView.paginated_keyphrases_with_total_counts_for_article_between(@article_id, @start_date, @end_date, page)
        
    render :partial => 'article_stats/keyphrases', :locals => {:keyphrase_counts => @keyphrase_counts} and return
  end
end
