class ESal::TutorialsController < ESal::Base

  def index
  end
  
  def show
  end
  
  def list
  end
  
  def new
    @tutorial = Tutorial.new
    set_current_user_id
    get_original_categories
  end

  def create
      @tutorial = Tutorial.new(tutorial_params)
      # raise params.inspect
      if @tutorial.save
        redirect_to action: 'index', notice: "チュートリアル「#{@tutorial.title}」を保存しました。"
      else
        get_original_categories
        render 'new' 
      end
  end

  private
    def tutorial_params
      params.require(:tutorial).permit(
                                        :id, :title, :user_id, :photo_id, :original_category_id, :status, :comment_enable_flg,
                                        :datetime_for_display,
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
