class Oracle::AnswersController < ApplicationController

  before_filter :find_question

  def index
    @answers = @question.answers
  end

  private
  def find_question
    @question = ::Oracle::Question.find(params[:question_id])
  end
end