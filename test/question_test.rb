require File.join(File.dirname(__FILE__), 'test_helper')

class QuestionTest < ActiveSupport::TestCase
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
    
    context "when assigned a suitable answer" do
      setup do
        answer = ::Oracle::Answer.create(:body => "42")
        @question.suitable_answer = answer
        @question.save
      end
      should "become closed" do
        @question.reload
        assert_equal(true, @question.closed?)
      end
    end
    
    should "be closeable after the initial answer period" do
      @question.stubs(:after_initial_answer_period?).returns(true)
      assert_equal(true, @question.closeable?)
    end
    
    should "not be overdue if less than 7 days have passed since its creation" do
      @question.stubs(:created_at).returns(1.minute.ago)
      assert_equal(false, @question.overdue?)
    end
    
    should "be overdue if more than 7 days have passed since its creation" do
      @question.stubs(:created_at).returns(10.days.ago)
      assert_equal(true, @question.overdue?)
    end
    
  end
end