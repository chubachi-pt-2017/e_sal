class ESal::ProgrammingsController < ESal::Base
  before_action :set_programming, only: [:show]
  
  def index
    status = "all"
    if params[:status]
      status = params[:status]
    end
    
    @status = status
    @programmings = Programming.get_list(current_user.id, status).page(params[:page]).per(LIST_NUM_PER_PAGE)
    
  end

  def show
    @programming_answer = @programming.programming_answers.find_by(user_id: current_user.id)
  end
  
  private
  
  def set_programming
    @programming = Programming.find(params[:id])
  end
end
