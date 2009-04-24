require "test_helper"

class Oracle::AnswersControllerTest < ActionController::TestCase
  context "An Answer" do
    setup do
      @controller = Oracle::AnswersController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new
      
      @question = Oracle::Question.create(:body => "what is the meaning of life?")
    end

    context "list for a given question" do
      setup do
        get :index, :question_id => @question
      end
      should_respond_with :success
    end

  end
end