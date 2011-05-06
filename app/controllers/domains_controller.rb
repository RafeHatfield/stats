class DomainsController < ApplicationController
  
  before_filter :set_start_and_end_date

  def domains_for_writer  
    domain_counts = DailyDomainView.domain_counts_for_writer_between(params[:writer_id], @start_date, @end_date)
    sleep 3
    render :partial => 'article_stats/domains', :locals => {:domain_counts => domain_counts} and return
  end
  
  def domains_for_article
    domain_counts = DailyDomainView.domain_counts_for_article_between(params[:article_id], @start_date, @end_date)
    sleep 3
    render :partial => 'article_stats/domains', :locals => {:domain_counts => domain_counts} and return
  end  

  def sources_for_writer
    source_counts = DailyDomainView.source_counts_for_writer_between(params[:writer_id], @start_date, @end_date)
    sleep 3
    render :json => source_counts.map{|source_sym, count| [I18n.t("report.#{source_sym.to_s}"), count]}.to_json
  end
  
  def sources_for_article
    source_counts = DailyDomainView.source_counts_for_article_between(params[:article_id], @start_date, @end_date)
    sleep 3
    render :json => source_counts.map{|source_sym, count| [I18n.t("report.#{source_sym.to_s}"), count]}.to_json
  end
  
end
