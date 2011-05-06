class DomainsController < ApplicationController
  before_filter :set_start_and_end_date

  def for_writer  
    domain_counts = DailyDomainView.domain_counts_for_writer_between(params[:writer_id], @start_date, @end_date)
    render :partial => 'domains', :locals => {:domain_counts => domain_counts} and return
  end
  
  def for_article
    domain_counts = DailyDomainView.domain_counts_for_article_between(params[:article_id], @start_date, @end_date)
    render :partial => 'domains', :locals => {:domain_counts => domain_counts} and return
  end  
  
end
