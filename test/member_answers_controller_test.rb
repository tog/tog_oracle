require "test_helper"

class Member::Oracle::AnswersControllerTest < ActionController::TestCase
  context "An Answer" do
    setup do
      @controller = Member::Oracle::AnswersController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
      
      @user = create_user_without_validation
      @controller.stubs(:current_user).returns(@user)
      
      @question = Factory(:question)
    end
    
    context "new" do
      setup do
        get :new, :question_id => @question
      end
      should_respond_with :success
    end
    
    context "when created successfully" do
      setup do
        post :create, :question_id => @question, :answer => { :body => "42" }
      end
      should_redirect_to("the list of answers to that question") { oracle_question_answers_path(@question) }
      should_set_the_flash_to "Answer posted."
    end
    
    context "when failing to be created" do
      setup do
        post :create, :question_id => @question, :answer => { :body => "" }
      end
      should_render_template :new
      should_set_the_flash_to "Error during answer creation."
    end
    
    context "for a closed question" do
      setup do
        @question.close!
        @question.save          
      end      
      context "an attempt to create it" do
        setup do
          get :new, :question_id => @question
        end
        should_redirect_to("the list of answers to that question") { oracle_question_answers_path(@question) }
        should_set_the_flash_to "You cannot answer a question that is already closed."        
      end
      context "an attempt to create it directly by posting to the create action" do
        setup do
          post :create, :question_id => @question, :answer => { :body => "42" }
        end
        should_redirect_to("the list of answers to that question") { oracle_question_answers_path(@question) }
        should_set_the_flash_to "You cannot answer a question that is already closed."        
      end      
    end
    
  end        
end

