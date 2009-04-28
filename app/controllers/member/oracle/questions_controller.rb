class Member::Oracle::QuestionsController < Member::BaseController

  before_filter :find_question, :only => [:edit]

  def new
    @question = ::Oracle::Question.new
  end

  def create
    params[:question].merge!(:user => current_user)
    question = ::Oracle::Question.new(params[:question])
    if question.save
      flash[:ok] = I18n.t("member.oracle.questions.create.saved_ok")
      redirect_to member_oracle_questions_path
    else
      flash[:error] = I18n.t("member.oracle.questions.create.saved_error")
      render :action => :new
    end
  end

  def index
    @questions = current_user.questions.opened
  end

  def edit
  end

  protected
  def find_question
    @question = ::Oracle::Question.find(params[:id])
  end

  def check_if_closeable
    unless @question.closeable?
      flash[:error] = I18n.t("member.oracle.questions.question_not_closeable")
      redirect_to member_oracle_questions_path
    end
  end
end