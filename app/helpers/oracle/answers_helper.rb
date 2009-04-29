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
    link_to I18n.t("oracle.answers.answer_this_question"), new_member_oracle_question_answer_path(question) if @question.opened?
  end
  
  def answer_and_rating_stars(answer)
    out = []
    out << answer.body
    out << rating_stars(answer,'ico/star_on.gif','ico/star.gif')
    out << content_tag(:span, "SUITABLE") if answer.suitable?
    out.join(" ")
  end
  
  # TODO: this should go to tog_core into the RatesHelper module
  # Till then it stays here, since we cannot rely on the host app defining this helper.
  def rating_stars(rateable, filled, empty)
    if rateable.total_ratings > 0
      return stars(rateable, :filled_star => image_tag(filled), :empty_star => image_tag(empty)) do |content,rating,filled|
        link_to content, member_rate_path(:type => rateable.class.name, :id => rateable.id, :rate => rating), :id => "rating-link-#{rating}"
      end
    else
      return [1,2,3,4,5].collect{|i| 
        link_to image_tag(empty), member_rate_path(:type => rateable.class.name, :id => rateable.id, :rate => i), :id => "rating-link-#{i}"
      }
    end
  end
end