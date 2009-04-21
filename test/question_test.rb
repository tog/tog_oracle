require File.join(File.dirname(__FILE__), 'test_helper')

# class QuestionTest < ActiveSupport::TestCase
class QuestionTest < Test::Unit::TestCase
  context "A question" do
    setup do
      @question = ::Oracle::Question.create(:body => "Life, universe?")
    end
    
    # context "'s suitable_answer_id" do
    #   setup do
    #     @answer = ::Oracle::Answer.create(:body => "42")
    #   end
    #   should "be gettable" do
    #     @question.suitable_answer = @answer
    #     @question.save
    #     assert_equal(@answer.id, @question.suitable_answer_id)
    #   end
    #   should "be settable" do
    #     @question.suitable_answer_id = @answer.id
    #     @question.save
    #     assert_equal(@answer, @question.suitable_answer)
    #   end
    # end
  end
end