class ArticleVotesController < ApplicationController
  before_filter :set_start_and_end_date, :only => [:index, :show]
  before_filter :get_user, :only => [:index, :show]
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
  
  # article votes for a given writer
  # http://localhost:3000/article_votes?writer_id=587644&key=2Srx
  def index
    @articles_votes = ArticleVote.votes_for_writer_between(params[:writer_id], @start_date, @end_date, params[:limit] || @@PER_PAGE, params[:offset] || 0)
    render :layout => false
  end
  
  def show
    @article = Article.find(params[:id])
    article_votes = ArticleVote.vote_counts_for_article_between(params[:id], @start_date, @end_date)
    render :json => article_votes.to_json
  end

  def new
    article_id = params[:article_id]
    if article_id.present?
      @article = Article.find(article_id)
      @article_vote = @article.article_votes.build({:writer_id => @article.writer_id, :article_id => article_id, :title => @article.title})
    end
    @articles = Article.where(:writer_id => '587633')
    render :layout => false
  end  
end
