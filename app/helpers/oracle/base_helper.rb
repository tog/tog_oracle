module Oracle
  module BaseHelper
    def question_status_tag(question)
      question.opened? ? content_tag(:p, I18n.t("oracle.questions.question_open"), :class => "open_question") : 
                         content_tag(:p, I18n.t("oracle.questions.question_closed"), :class => "closed_question")
    end
  end
end