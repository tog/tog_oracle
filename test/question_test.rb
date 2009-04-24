require File.join(File.dirname(__FILE__), 'test_helper')

class QuestionTest < ActiveSupport::TestCase
  context "The Question class" do
    setup do
      @q1 = ::Oracle::Question.create(:body => "Why?")
      @q2 = ::Oracle::Question.create(:body => "What?")
      @q3 = ::Oracle::Question.create(:body => "When?")
      @q1.stubs(:overdue?).returns(true)
      @q2.stubs(:overdue?).returns(false)
      @q3.stubs(:overdue?).returns(true)
      # (rdb:1) Oracle::Question.all.map { |qu| qu.object_id }
      # [46203780, 46202630, 46202580, 46202540]
      # (rdb:1) [@q1, @q2, @q3].map { |qu| qu.object_id }
      # [46286060, 46278780, 46273040]
      
      # this is needed so that "all" does not instantiate new objects
      # thus passing by the above stubbing
      ::Oracle::Question.stubs(:all).returns([@q1, @q2, @q3])      
    end
    
    should "return the overdue ones" do
      overdues = ::Oracle::Question.overdues
      assert_contains(overdues, @q1)
      assert_contains(overdues, @q3)
      assert_does_not_contain(overdues, @q2)
    end
    
    should "be able to close the overdue questions" do
      #TODO: and send the notifications
      ::Oracle::Question.close_overdues#_and_send_notifications
      assert_equal(true, @q1.closed?)
      assert_equal(false, @q2.closed?)
      assert_equal(true, @q3.closed?)
    end
    
  end
  
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