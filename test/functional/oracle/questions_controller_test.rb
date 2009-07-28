require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class Oracle::QuestionsControllerTest < ActionController::TestCase
  context "A Question" do
    setup do
      @controller = Oracle::QuestionsController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
            
      @user = Factory(:user, :login => 'chavez')
      @controller.stubs(:current_user).returns(@user)
      @question = Factory(:question, :user => @user)

    end
    
    context "update" do
      context "for the question's publisher" do
        setup do
          put :update, :id => @question, :params => { :question => Factory.attributes_for(:question) }
        end
        should_set_the_flash_to "Question updated."
        should_redirect_to("the list of answers to that question") { oracle_question_answers_path(@question) }
      end
      
      context "for someone other than the question's publisher" do
        setup do
          @controller.stubs(:current_user).returns(Factory(:user, :login => 'fidel'))          
          put :update, :id => @question, :params => { :question => Factory.attributes_for(:question) }
        end
        # should_set_the_flash_to "Error during question update."
        should_redirect_to("the login page") { login_path }
      end
    end
    
    context "list of closed questions" do
      setup do
        get :closed
      end
      should_respond_with :success
    end
  end
  
end