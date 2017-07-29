class ESal::TutorialsController < ESal::Base
  before_action :set_tutorial, only: [:show, :edit, :update, :destroy]

  def index
    @tutorials = Tutorial.get_by_user_id(current_user.id).page(params[:page]).per(LIST_NUM_PER_PAGE)
  end

  def show
    @comment = @tutorial.comments.build
    @comments = @tutorial.comments
    @number_of_likes = TutorialLike.get_number_of_likes(params[:id])
    @number_of_dislikes = TutorialDislike.get_number_of_dislikes(params[:id])
    @press_like_button = TutorialLike.liked?(current_user.id, params[:id])
    @press_dislike_button = TutorialDislike.disliked?(current_user.id, params[:id])
    @current_login_user_id = current_user.id
  end

  def list
    @tutorials = Tutorial.published_tutorials.page(params[:page]).per(LIST_NUM_PER_PAGE)
    @list_title = "公開中"
  end

  def main_category_list
    if params[:main_category].blank?
      redirect_to e_sal_path
      return
    end

    @tutorials = Tutorial.get_by_main_category(params[:main_category]).page(params[:page]).per(LIST_NUM_PER_PAGE)
    @list_title = @tutorials[0].original_category.main_category.name
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

  def preview
    if params[:preview].blank?
      render_404
      return
    end
    set_preview_data
  end

  private
    def set_preview_data
      @tutorial = Tutorial.new
      @tutorial.title = params[:tutorial][:title]
      @body = params[:tutorial][:tutorial_content_attributes][:body]
      if params[:tutorial][:datetime_for_display].present?
        @tutorial.datetime_for_display = params[:tutorial][:datetime_for_display]
      else
        @tutorial.datetime_for_display = Time.now
      end
      @preview = "preview"
    end
  
    def set_tutorial
      @tutorial = Tutorial.find(params[:id])
    end

    def e_sal_tutorial_params
      params.fetch(:tutorial, {}).permit( 
                                          :id, :title, :user_id, :photo_id, :original_category_id, :status,
                                          :comment_enable_flg, :datetime_for_display,
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
