class Oracle::QuestionsController < ApplicationController

  def update
    question = ::Oracle::Question.find(params[:id])
    if question.update_attributes(params[:question])
      flash[:ok] = "Question updated"
      redirect_to oracle_question_answers_path(question)
    else
      flash[:error] = "Error during question update"
      redirect_to oracle_question_answers_path(question)
    end
  end
end