module AnswersHelper
    
  include Oracle::BaseHelper
  
  def question_and_list_of_answers(question, answers)
    if current_user == question.user
      #TODO: the result of this rendering would have to be captured in a var.
      # and returned      
      # render :template => "oracle/answers/index_forx_publisher"
    end
  end
  
  def answer_list(question, answers)
    if current_user == question.user
      render :partial => "answer_for_publisher", :collection => answers, :as => :answer
    else
      render :partial => "answer", :collection => answers
    end
  end
  
  def answer_this_question_link(question)
    link_to "Answer this question", new_member_oracle_question_answer_path(question) if @question.opened?
  end
end