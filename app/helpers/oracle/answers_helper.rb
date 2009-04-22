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
end