class DomainsController < ApplicationController
  
  before_filter :set_start_and_end_date

  def domains_for_writer
    @writer_id = params[:writer_id]  
    
    @domain_counts = DailyDomainView.domain_counts_for_writer_between(@writer_id, @start_date, @end_date)

    sleep 10
    
    render :partial => 'article_stats/domains', :locals => {:domain_counts => @domain_counts} and return
  end
  
  def domains_for_article
    @article_id = params[:article_id]  
    
    @domain_counts = DailyDomainView.domain_counts_for_article_between(@article_id, @start_date, @end_date)

    sleep 10
    
    render :partial => 'article_stats/domains', :locals => {:domain_counts => @domain_counts} and return
  end  

end
