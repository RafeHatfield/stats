class KeyphrasesController < ApplicationController
  before_filter :set_start_and_end_date
  
  def index
    page = params[:page] || 1
    per_page = 20
    @article_id = params[:suite101_article_id]
    
    @keyphrase_counts = DailyKeyphraseView.keyphrases_with_total_counts_for_article_between(@article_id, @start_date, @end_date)
    @keyphrase_counts = @keyphrase_counts[((page.to_i - 1) * per_page)...(page.to_i * per_page)]
    @keyphrase_counts.instance_eval <<-EVAL
      def current_page
        #{page || 1}
      end
      def num_pages
        count
      end
      def limit_value                                                                               
        20
      end
    EVAL
    
    render :partial => 'article_stats/keyphrases', :locals => {:keyphrase_counts => @keyphrase_counts} and return
  end
end
