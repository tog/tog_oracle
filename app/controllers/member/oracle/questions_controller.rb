class Member::Oracle::QuestionsController < Member::BaseController
  def new
    @question = ::Oracle::Question.new
  end
  
  def create
    question = ::Oracle::Question.new(params[:question])
    if question.save
      flash[:ok] = "Question created"
      redirect_to oracle_questions_path
    else
      render :new
    end
  end
end