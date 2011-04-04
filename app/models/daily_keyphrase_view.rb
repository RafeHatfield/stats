class DailyKeyphraseView < ActiveRecord::Base
  belongs_to :article  
  validates_presence_of :date, :article_id, :writer_id, :count
  
  # Get the total number of views for each keyphrase for writer_id between start_date and end_date
  # Ordered by total count descending.
  def self.keyphrases_with_total_counts_for_writer_between(writer_id, start_date, end_date, options={})  
    keyphrase_counts = DailyKeyphraseView.where(:writer_id => writer_id).between(start_date, end_date).group("keyphrase").select("keyphrase, SUM(count) as sum_count").order("sum_count desc")
    if options[:limit]
      keyphrase_counts = keyphrase_counts.limit(options[:limit])
    end
    keyphrase_counts.sum("count").to_a
  end
  
  # Get the total number of views for each keyphrase for an article between start_date and end_date
  # Ordered by total count descending.
  def self.keyphrases_with_total_counts_for_article_between(article_id, start_date, end_date)
    keyphrases = DailyKeyphraseView.between(start_date, end_date).joins(:article) & Article.where(:id => article_id)
    keyphrase_counts = keyphrases.group("keyphrase").select("keyphrase").order("sum_count desc")
    keyphrase_counts.sum("count").to_a
  end
  
  # Keyphrase Views on and between start_date and end_date
  def self.between(start_date, end_date)
    where(:date => start_date.to_date...(end_date.to_date + 1.day))
    # Note: With "..." range rails generates a sql where clause with 
    # date >= d1, date < d2 so we add an extra day to include today.
  end
  
  def self.per_page
    20
  end
  
  def self.paginated_keyphrases_with_total_counts_for_article_between(article_id, start_date, end_date, page)
    keyphrase_counts = DailyKeyphraseView.keyphrases_with_total_counts_for_article_between(article_id, start_date, end_date)
    keyphrase_counts = keyphrase_counts[((page.to_i - 1) * per_page)...(page.to_i * per_page)]
    keyphrase_counts.instance_eval <<-EVAL
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
    keyphrase_counts
  end
end