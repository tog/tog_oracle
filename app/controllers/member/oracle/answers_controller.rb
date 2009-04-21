class Member::Oracle::AnswersController < Member::BaseController

  before_filter :find_question

  def new
    @answer = ::Oracle::Answer.new
  end

  def create
    answer_params = params[:answer].merge(:question => @question)
    @answer = ::Oracle::Answer.new(answer_params)
    if @answer.save
      flash[:ok] = "Answer posted."
      redirect_to oracle_question_answers_path(@question)
    else
      flash[:error] = "Error during answer creation."
      render :action => :new
    end
  end

  private
  def find_question
    @question = ::Oracle::Question.find(params[:question_id])
  end
end