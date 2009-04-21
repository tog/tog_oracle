require "test_helper"

class Oracle::AnswersControllerTest < ActionController::TestCase
  context "An Answer" do
    setup do
      @controller = Oracle::AnswersController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
    end

    context "list for a given question" do
      setup do
        get :index
      end
      should_respond_with :success
    end

  end
end