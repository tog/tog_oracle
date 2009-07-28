require File.join(File.dirname(__FILE__), '..', 'test_helper')

class QuestionMailerTest < ActionMailer::TestCase
  context "A QuestionMailer" do
    setup do
      ActionMailer::Base.deliveries.clear
      q1 = Factory(:question, :user => create_user_without_validation)
      q2 = Factory(:question, :user => create_user_without_validation)
      ::Oracle::Question.any_instance.stubs(:overdue?).returns(true)
    end
    #TODO: this should be put back once I create a proper user factory    
    # context "sending overdue notifications when there are 2 overdue questions" do
    #   setup do
    #     ::Oracle::Question.send_close_requests_for_overdues
    #   end
    #   should_change "::ActionMailer::Base.deliveries.length", :by => 2
    # end
  end
end