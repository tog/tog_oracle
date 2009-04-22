require File.join(File.dirname(__FILE__), 'test_helper')

# class QuestionTest < ActiveSupport::TestCase
class QuestionTest < Test::Unit::TestCase
  context "A question" do
    setup do
      @question = ::Oracle::Question.create(:body => "Life, universe?")
    end
    
    context "'s suitable_answer_id" do
      setup do
        @answer = ::Oracle::Answer.create(:body => "42")
      end
      should "be gettable" do
        @question.suitable_answer = @answer
        @question.save
        assert_equal(@answer.id, @question.suitable_answer_id)
      end
      should "be settable" do
        @question.suitable_answer_id = @answer.id
        @question.save
        assert_equal(@answer, @question.suitable_answer)
      end
    end
    
    context "closing" do
      should "be possible after 1 hour has passed after creation but no more than 7 days" do
        @question.stubs(:created_at).returns(1.day.ago)
        assert_true @question.closeable?
      end
      should "not be possible if 1 hour has not passed since the question's creation" do
        @question.stubs(:created_at).returns(3.minutes.ago)
        assert_false @question.closeable?
      end
      should "not be possible if 1 hour has not passed since the question's creation" do
        @question.stubs(:created_at).returns(10.days.ago)
        assert_false @question.closeable?
      end      
    end
  end
end