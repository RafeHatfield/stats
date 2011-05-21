require 'test_helper'

class ArticleVoteTest < ActiveSupport::TestCase
  should "be valid" do
    assert ArticleVote.new.valid?
  end
end
