class SourcesController < ApplicationController

  before_filter :set_start_and_end_date
  after_filter do
    sleep 3
  end

  def for_writer
    source_counts = DailyDomainView.source_counts_for_writer_between(params[:writer_id], @start_date, @end_date)
    render :json => source_counts.map{|source_sym, count| [I18n.t("report.#{source_sym.to_s}"), count]}.to_json
  end
  
  def for_article
    source_counts = DailyDomainView.source_counts_for_article_between(params[:article_id], @start_date, @end_date)
    render :json => source_counts.map{|source_sym, count| [I18n.t("report.#{source_sym.to_s}"), count]}.to_json
  end

end
