class ESal::ProgrammingsController < ESal::Base
  before_action :set_programming, only: [:show, :edit, :update, :destroy]
  before_action :find_user, only: [:new, :create]
  before_action :get_programming_answer, only: [:edit, :destroy]
  
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
  
  def new
    @programming = @user.programmings.build()
  end
  
  def create
    @programming = @user.programmings.build(programming_params)
    
    params[:programming][:confirmed] = false if params[:back]
    
    if @programming.save?
      respond_to do |format|
        format.html {redirect_to e_sal_programming_path(@programming.id), notice: "登録が完了しました"}
      end
    else
      respond_to do |format|
        format.html {render 'new'}
      end
    end
  end
  
  def edit
    unless @programming_answer.nil?
      respond_to do |format|
        format.html {redirect_to e_sal_programming_path(@programming.id), alert: "既に回答が投稿されているため、編集できません"}
      end
      return
    end
  end
  
  def update

    params[:programming][:confirmed] = false if params[:back]

    @programming.attributes = programming_params
    
    if @programming.save
      respond_to do |format|
        format.html {redirect_to e_sal_programming_path(@programming.id), notice: "更新が完了しました"}
      end
    else
      respond_to do |format|
        format.html {render 'edit'}
      end
    end
  end
  
  def destroy
    unless @programming_answer.nil?
      respond_to do |format|
        format.html {redirect_to e_sal_programming_path(@programming.id), alert: "既に回答が投稿されているため削除できません"}
      end
      return
    end
    
    if @programming.destroy
      respond_to do |format|
        format.html {redirect_to e_sal_programmings_path(status: 'own'), notice: "削除が完了しました"}
      end
    else
      respond_to do |format|
        format.html {render 'show'}
      end
    end
  end
  
  private
  
  def get_programming_answer
    @programming_answer = @programming.programming_answers.find_by(programming_id: @programming.id)
  end
  
  def find_user
    @user = User.find_by(id: current_user.id)
  end
  
  def set_programming
    @programming = Programming.find(params[:id])
  end
  
  def programming_params
    params.require(:programming).permit(
      :title, :question_desc, :correct_answer, :confirmed)
  end
end
