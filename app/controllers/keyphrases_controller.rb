class KeyphrasesController < ApplicationController
  before_filter :set_start_and_end_date
  after_filter do
    sleep 1
  end
  
  def for_article
    keyphrase_counts = DailyKeyphraseView.keyphrases_with_total_counts_for_article_between(params[:article_id], @start_date, @end_date)
    render :partial => 'keyphrases', :locals => {:keyphrase_counts => keyphrase_counts} and return
  end
  
  def for_writer
    keyphrase_counts = DailyKeyphraseView.keyphrases_with_total_counts_for_writer_between(params[:writer_id], @start_date, @end_date)
    render :partial => 'keyphrases', :locals => {:keyphrase_counts => keyphrase_counts} and return
  end

end
