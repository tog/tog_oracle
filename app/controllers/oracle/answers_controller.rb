class Oracle::AnswersController < ApplicationController

  before_filter :find_question

  def index
  end

  private
  def find_question
    @question = ::Oracle::Question.find(params[:question_id])
  end
end