class Member::Oracle::AnswersController < Member::BaseController

  before_filter :find_question
  before_filter :check_if_question_closed

  def new
    @answer = ::Oracle::Answer.new
  end

  def create
    answer_params = params[:answer].merge(:question => @question).merge(:user => current_user)
    @answer = ::Oracle::Answer.new(answer_params)
    if @answer.save
      flash[:ok] = I18n.t("member.oracle.answers.create.saved_ok")
      redirect_to oracle_question_answers_path(@question)
    else
      flash[:error] = I18n.t("member.oracle.answers.create.saved_error")
      render :action => :new
    end
  end

  private
  def find_question
    @question = ::Oracle::Question.find(params[:question_id])
  end
  def check_if_question_closed
    if @question.closed?
      flash[:error] = I18n.t("member.oracle.answers.cannot_answer_already_closed")
      redirect_to oracle_question_answers_path(@question)
    end
  end
end