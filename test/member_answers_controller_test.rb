require "test_helper"

class Member::Oracle::AnswersControllerTest < ActionController::TestCase
  context "An Answer" do
    setup do
      @controller = Member::Oracle::AnswersController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
      
      @user = create_user_without_validation
      @controller.stubs(:current_user).returns(@user)      
    end
  end
    
  context "new" do
    setup do
      get :new, :question_id => 1
    end
    should_respond_with :success
  end
    
end

