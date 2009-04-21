class Member::Oracle::QuestionsController < Member::BaseController
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
    @questions = current_user.questions.open
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
end