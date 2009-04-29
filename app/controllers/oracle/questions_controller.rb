class Oracle::QuestionsController < ApplicationController

  only_owner
  before_filter :find_question, :only => [:update]

  def update
    # question = ::Oracle::Question.find(params[:id])
    if @question.update_attributes(params[:question])
      flash[:ok] = I18n.t("oracle.questions.update.saved_ok")
      redirect_to oracle_question_answers_path(@question)
    else
      flash[:error] = I18n.t("oracle.questions.update.saved_error")
      redirect_to oracle_question_answers_path(@question)
    end
  end

  def index
    @questions = ::Oracle::Question.opened
  end

  private
  def find_question
    @question = ::Oracle::Question.find(params[:id])
  end
end