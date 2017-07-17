class ESal::TutorialsController < ESal::Base
  before_action :set_e_sal_tutorial, only: [:show, :edit, :update, :destroy]

  def index
    @tutorials = Tutorial.get_by_user_id(current_user.id)
  end

  def show
  end

  def new
    @tutorial = Tutorial.new
    set_current_user_id
    get_original_categories
  end

  def edit
    get_original_categories
  end

  def create
    @tutorial = Tutorial.new(e_sal_tutorial_params)
    respond_to do |format|
      if @tutorial.save
        format.html { redirect_to e_sal_tutorials_path, notice: "チュートリアル「#{params[:tutorial][:title]}」を作成しました。" }
      else
        get_original_categories
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @tutorial.update(e_sal_tutorial_params)
        format.html { redirect_to e_sal_tutorials_path, notice: "「#{@tutorial.title}」のチュートリアルが更新されました。" }
      else
        get_original_categories
        format.html { render :edit }
      end
    end
  end

  def destroy
    deleted_tutorial_title = @tutorial.title
    if @tutorial.destroy
      message = "チュートリアル「#{deleted_tutorial_title}」を削除しました。"
    else
      message = "チュートリアル「#{deleted_tutorial_title}」の削除に失敗しました。"
    end
    
    respond_to do |format|
      format.html { redirect_to e_sal_tutorials_url, notice: message }
    end
  end

  private
    def set_e_sal_tutorial
      @tutorial = Tutorial.find(params[:id])
    end

    def e_sal_tutorial_params
      params.fetch(:tutorial, {}).permit( 
                                          :id, :title, :user_id, :photo_id, :original_category_id, :status, :comment_enable_flg, :datetime_for_display,
                                          :tutorial_content_attributes => [:id, :tutorial_id, :body, :_destroy]
                                        )
    end

    def get_original_categories
      @original_categories = OriginalCategory.get_by_user_id(current_user.id)
    end
  
    def set_current_user_id
      @tutorial.user_id = get_current_user_id
    end
end
