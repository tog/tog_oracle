require "test_helper"

class Member::Oracle::AnswersControllerTest < ActionController::TestCase
  context "An Answer" do
    setup do
      @controller = Member::Oracle::AnswersController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
      
      @user = create_user_without_validation
      @controller.stubs(:current_user).returns(@user)
      
      @question = ::Oracle::Question.create(:body => "What is the meaning of life?") 
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
    
  end        
end

