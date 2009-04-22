module Oracle
  module BaseHelper
    def question_status_tag(question)
      question.opened? ? content_tag(:p, "Question open", :class => "open_question") : 
                         content_tag(:p, "Question closed", :class => "closed_question")
    end
  end
end