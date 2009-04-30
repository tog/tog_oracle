require "test_helper"

class Oracle::QuestionsControllerTest < ActionController::TestCase
  context "A Question" do
    setup do
      @controller = Oracle::QuestionsController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
      
      @question = Factory(:question)
    end
    
    context "update" do
      context "for the question's publisher" do
        setup do
          @controller.stubs(:current_user).returns(@question.user)
          put :update, :id => @question, :params => { :question => Factory.attributes_for(:question) }
        end
        should_set_the_flash_to "Question updated."
        should_redirect_to("the list of answers to that question") { oracle_question_answers_path(@question) }
      end
      
      context "for someone other than the question's publisher" do
        setup do
          @controller.stubs(:current_user).returns(create_user_without_validation)
          put :update, :id => @question, :params => { :question => Factory.attributes_for(:question) }
        end
        # should_set_the_flash_to "Error during question update."
        should_redirect_to("the login page") { login_path }
      end
    end
  end
  
end