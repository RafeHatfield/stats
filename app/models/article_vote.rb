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
    
    article_ids.each do |aid|
      result << votes_detail_for_article(article_votes.to_a, aid)
    end
    result
  end
    
  def self.vote_counts_for_article_between(article_id, start_date, end_date)
    total_vote_counts = ArticleVote.
      where(:article_id => article_id).
      select("vote, note").
      between(start_date, end_date)
    
    up_vote_count = total_vote_counts.to_a.count{|vote| vote.vote == true}
    down_vote_count = total_vote_counts.to_a.count{|vote| vote.vote == false}
    notes = total_vote_counts.to_a.find_all{|v| v.note if v.note.present?}.map{|v|v.note}
    
    counts = {:helpful => up_vote_count, :not_helpful => down_vote_count}.map{|source_sym, count| [I18n.t("report.#{source_sym.to_s}"), count]}.to_json
    empty = (up_vote_count == 0) && (down_vote_count == 0)
    {:counts => counts, :notes => notes, :empty => empty}
  end
  
private

  def self.votes_detail_for_article(votes, aid)
    article_vote = votes.find{|v| v.article_id == aid}
    up_vote_count = votes.count{|v| (v.article_id == aid) && v.vote == true}
    down_vote_count = votes.count{|v| (v.article_id == aid) && v.vote == false}
    {:id => article_vote.article_id, :title => article_vote.title, :permalink => article_vote.permalink, :up_votes_count => up_vote_count, :down_votes_count => down_vote_count, :note => article_vote.note}
  end
  
end