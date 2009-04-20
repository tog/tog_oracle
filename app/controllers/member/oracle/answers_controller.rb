class Member::Oracle::AnswersController < Member::BaseController

  before_filter :find_question

  def new
    @answer = ::Oracle::Answer.new
  end

  def create
    @answer = ::Oracle::Answer.new(params[:answer])
    if @answer.save
      flash[:ok] = "Answer posted."
      redirect_to oracle_question_answers_path(@question)
    end
  end

  private
  def find_question
    @question = ::Oracle::Question.find(params[:question_id])
  end
end