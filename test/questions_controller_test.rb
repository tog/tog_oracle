require "test_helper"

class Member::Oracle::QuestionsControllerTest < ActionController::TestCase
  context "A Question" do
    setup do
      @controller = Member::Oracle::QuestionsController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
    end
    
    context "creation" do
      setup do
        @controller.stubs(:login_required).returns(true)
        get :new
      end
      should_respond_with :success
    end
    
  end
end