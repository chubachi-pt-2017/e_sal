class ESal::ProgrammingAnswersController < ESal::Base
  before_action :find_programming
  before_action :set_programming_answer, only: [:show, :edit, :update]
  before_action :set_status, only: [:create, :update]

  def show
    unless ProgrammingAnswer.has_answered?(current_user.id, @programming.id)
      respond_to do |format|
        format.html {redirect_to e_sal_programming_path(@programming.id), notice: "回答済みの場合のみ他の人の回答を閲覧できます"}
      end
      return
    end
  end

  def new
    @programming_answer = @programming.programming_answers.new
  end

  def create

    params[:programming_answer][:user_id] = current_user.id
    
    @programming_answer = @programming.programming_answers.new(programming_answer_params)
    
    respond_to do |format|
      if @programming_answer.save
        format.html {redirect_to e_sal_programming_programming_answer_path, notice: "保存が完了しました"}
      else
        format.html {render :new}
      end
    end
  end

  def edit
    unless chk_current_user
      respond_to do |format|
        format.html {redirect_to e_sal_programmings_path, notice: "他の人の回答は編集できません"}
      end
      return
    end
  end

  def update

    @programming_answer.attributes = programming_answer_params

    respond_to do |format|
      if @programming_answer.save
        format.html {redirect_to e_sal_programming_programming_answer_path, notice: "保存が完了しました"}
      else
        format.html {render :edit}
      end
    end
  end

  # get list others
  def list
    
    unless ProgrammingAnswer.has_answered?(current_user.id, @programming.id)
      respond_to do |format|
        format.html {redirect_to e_sal_programming_path(@programming.id), notice: "回答済みの場合のみ他の人の回答を閲覧できます"}
      end
      return
    end
    
    @programming_answers = ProgrammingAnswer.others(current_user.id, @programming.id).page(params[:page]).per(LIST_NUM_PER_PAGE)
    
  end
  
  private
  
  def chk_current_user
    @programming_answer.user_id == current_user.id
  end
  
  def find_programming
    @programming = Programming.find(params[:programming_id])
  end
  
  def programming_answer_params
    params.require(:programming_answer).permit(:programming_language, :tab_size, :answer_code,
                  :answer_result, :answer_status, :user_id)
  end
  
  def set_programming_answer
    @programming_answer = @programming.programming_answers.find_by(id: params[:id])
  end
  
  def set_status
    params[:programming_answer][:answer_status] = ProgrammingAnswer.answer_statuses[params[:programming_answer][:answer_status]]
  end
  
end
