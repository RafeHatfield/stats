class ArticleVote < ActiveRecord::Base
  attr_accessible :article_id, :date, :note, :vote, :writer_id
  
  validates_presence_of :article_id
  
  scope :for_writer, lambda {|writer_id| where(:writer_id => writer_id) }
  scope :between, lambda {|start_date, end_date| where(:date => start_date.to_date...(end_date.to_date + 1.day)) }
  
  belongs_to :article 
  
  def self.votes_for_writer_between(writer_id, start_date, end_date, limit, offset)
    article_votes = ArticleVote.
      for_writer(writer_id).
      select("article_id, title, permalink, vote, note").
      between(start_date, end_date).
      joins(:article).
      limit(limit).
      offset(offset)
      
    article_ids = article_votes.collect{|vote| vote.article_id}.uniq
    result = []
    
    article_ids.each do |id|
      result << votes_detail_for_article(article_votes.to_a, id)
    end
    result
  end
    
  def self.vote_counts_for_article_between(article_id, start_date, end_date, limit, offset)
    total_vote_counts = ArticleVote.
      where(:article_id => article_id).
      select("vote").
      between(start_date, end_date).
      limit(limit).offset(offset)
    
    up_vote_count = total_vote_counts.to_a.count{|vote| vote.vote == true}
    down_vote_count = total_vote_counts.to_a.count{|vote| vote.vote == false}
    {:helpful => up_vote_count, :not_helpful => down_vote_count}
  end
  
private

  def self.votes_detail_for_article(votes, id)
    vote = votes.find{|v| v.article_id == id}
    up_vote_count = votes.count{|vote| (vote.article_id == id) && vote.vote == true}
    down_vote_count = votes.count{|vote| (vote.article_id == id) && vote.vote == false}
    [vote.article_id, vote.title, vote.permalink, up_vote_count, down_vote_count, vote.note]
  end
  
end