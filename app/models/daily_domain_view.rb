class DailyDomainView < ActiveRecord::Base
  belongs_to :article
  
  validates_presence_of :date, :article_id, :writer_id, :count
  
  # Get the total number of views for each domain for writer_id between start_date and end_date
  # Ordered by total count descending.
  def self.domains_with_total_counts_for_writer_between(writer_id, start_date, end_date)  
    domain_counts = DailyDomainView.where(:writer_id => writer_id).between(start_date, end_date).group("domain").select("domain").order("sum_count desc").sum("count")
    domain_counts.to_a
  end
  
  # Domain Views on and between start_date and end_date
  def self.between(start_date, end_date)
    where(:date => start_date.to_date...(end_date.to_date + 1.day))
    # Note: With "..." range rails generates a sql where clause with 
    # date >= d1, date < d2 so we add an extra day to include today.
  end
end
