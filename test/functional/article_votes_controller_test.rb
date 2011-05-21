require 'test_helper'

class ArticleVotesControllerTest < ActionController::TestCase
        
  context "new action" do
    should "render new template" do
      get :new
      assert_template 'new'
    end
  end
    
  context "create action" do
    should "render new template when model is invalid" do
      ArticleVotes.any_instance.stubs(:valid?).returns(false)
      post :create
      assert_template 'new'
    end
    
    should "redirect when model is valid" do
      ArticleVotes.any_instance.stubs(:valid?).returns(true)
      post :create
      assert_redirected_to
    end
  end
      
  context "update action" do
    should "render edit template when model is invalid" do
      ArticleVotes.any_instance.stubs(:valid?).returns(false)
      put :update, :id => ArticleVotes.first
      assert_template 'edit'
    end
  
    should "redirect when model is valid" do
      ArticleVotes.any_instance.stubs(:valid?).returns(true)
      put :update, :id => ArticleVotes.first
      assert_redirected_to
    end
  end
      
end
