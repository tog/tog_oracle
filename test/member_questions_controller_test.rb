require File.join(File.dirname(__FILE__), 'test_helper')

class Member::Oracle::QuestionsControllerTest < ActionController::TestCase
  context "A Question" do
    setup do
      @controller = Member::Oracle::QuestionsController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new

      @user = create_user_without_validation
      @controller.stubs(:current_user).returns(@user)
    end

    context "new" do
      setup do
        get :new
      end
      should_respond_with :success
    end

    context "creation" do
      setup do
        post :create, :question => Factory.attributes_for(:question)
      end
      should_set_the_flash_to "Question created."
      should_redirect_to("the list of the user's questions") { member_oracle_questions_path }
    end

    context "failing creation" do
      setup do
        post :create, :question => { :title => "" }
      end
      should_set_the_flash_to "Error during question creation."
      should_render_template :new
    end

    context "list" do
      setup do
        get :index
      end
      should_respond_with :success
      # should_assign_to(:questions) { "current_user.questions" }
    end

    context "editing" do
      setup do
        @question = Factory(:question, :user => @user)
      end

      context "of a closed question" do
        setup do
          @controller.stubs(:current_user).returns(@question.user)
          ::Oracle::Question.any_instance.stubs(:closed?).returns(true)
          get :edit, :id => @question
        end
        should_redirect_to("the list of answers to that question") { oracle_question_answers_path(@question) }
        should_set_the_flash_to "A closed question can not be modified."
      end
      
      context "for the question's publisher" do
        setup do
          @controller.stubs(:current_user).returns(@question.user)
          get :edit, :id => @question
        end
        should_respond_with :success
        # put :update, :id => @question, :params => { :question => Factory.attributes_for(:question) }
      end

      context "for someone other than the question's publisher" do
        setup do
          @controller.stubs(:current_user).returns(create_user_without_validation)
          get :edit, :id => @question
          # put :update, :id => @question, :params => { :question => Factory.attributes_for(:question) }
        end
        should_redirect_to("the login page") { login_path }
      end
    end

    context "update" do
      setup do
        @question = Factory(:question, :user => @user)
      end

      context "of a closed question" do
        setup do
          ::Oracle::Question.any_instance.stubs(:closed?).returns(true)
          @question.stubs(:closed?).returns(true)
          put :update, :id => @question, :params => { :question => Factory.attributes_for(:question) }
        end
        should_redirect_to("the list of answers to that question") { oracle_question_answers_path(@question) }
        should_set_the_flash_to "A closed question can not be modified."
      end

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