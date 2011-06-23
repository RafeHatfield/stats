class ArticleVotesController < ApplicationController
  before_filter :set_start_and_end_date, :only => [:for_writer, :for_article]
  before_filter :get_user, :only => [:for_writer, :for_article]
  @@PER_PAGE = 20
  
  def create
    return if params[:spam_filter].present?
    
    article = Article.find_and_update_title_or_create({
      :id => params[:article_vote][:id],
      :title => params[:article_vote][:title],
      :writer_id => params[:article_vote][:writer_id],
      :permalink => params[:article_vote][:permalink]
    })
    date = Time.zone.utc_to_local(Time.now.utc.getutc)
    params[:article_vote][:date] = date.to_date
    article_vote = article.article_votes.build(params[:article_vote])
    if article_vote.save
      render :text => 'Thanks you.' and return
    else
      render :text => "Error occurred: #{article_vote.errors.full_messages.to_sentence}" and return
    end
  end
  
  def for_writer
    @votes = ArticleVote.article_votes_for_writer_between(params[:writer_id], @start_date, @end_date, params[:limit] || @@PER_PAGE, params[:offset] || 0)
    render :layout => false
  end
  
  def for_article
    article_votes = ArticleVote.votes_for_article_between(params[:article_id], @start_date, @end_date)
    render :json => article_votes.map{|sym, count| [I18n.t("report.#{sym.to_s}"), count]}.to_json
  end

end