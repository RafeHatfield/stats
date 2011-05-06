class KeyphrasesController < ApplicationController
  before_filter :set_start_and_end_date
  
  def for_article
    @article_id = params[:article_id]
    page = params[:page] || 1
    
    @keyphrase_counts = DailyKeyphraseView.paginated_keyphrases_with_total_counts_for_article_between(@article_id, @start_date, @end_date, page)
        
    sleep 3
        
    render :partial => 'article_stats/keyphrases', :locals => {:keyphrase_counts => @keyphrase_counts} and return
  end
  
  def for_writer
    @writer_id = params[:writer_id]  
    
    @keyphrase_counts = DailyKeyphraseView.paginated_keyphrases_with_total_counts_for_writer_between(@writer_id, @start_date, @end_date, 1)

    sleep 3
    
    render :partial => 'article_stats/keyphrases', :locals => {:keyphrase_counts => @keyphrase_counts} and return
  end

end
