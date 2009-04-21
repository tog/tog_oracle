class Member::Oracle::QuestionsController < Member::BaseController
  
  before_filter :check_if_already_closed, :only => [:close, :do_close]
  
  def new
    @question = ::Oracle::Question.new
  end
  
  def create
    params[:question].merge!(:user => current_user)
    question = ::Oracle::Question.new(params[:question])
    if question.save
      flash[:ok] = "Question created"
      redirect_to member_oracle_questions_path
    else
      flash[:error] = "Error during question creation"
      render :action => :new
    end
  end
  
  def index
    @questions = current_user.questions.opened
  end

  def edit
    @question = ::Oracle::Question.find(params[:id])
  end
  
  def close
    @question = ::Oracle::Question.find(params[:id])
    @answer = @question.suitable_answer
  end
  
  def do_close
    @question = ::Oracle::Question.find(params[:id])
    @question.close!
    if @question.save
      flash[:ok] = "Question closed"
      redirect_to member_oracle_questions_path
    else
      flash[:error] = "Error when closing question"
      render :action => "close"
    end
  end
  
  protected  
  def check_if_already_closed
    @question = ::Oracle::Question.find(params[:id])
    if @question.closed?
      flash[:error] = "Question already closed"
      redirect_to member_oracle_questions_path
    end
  end
end