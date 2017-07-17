class ESal::TutorialsController < ESal::Base
  before_action :set_e_sal_tutorial, only: [:show, :edit, :update, :destroy]

  def index
    @tutorials = Tutorial.all
  end

  def show
  end

  def new
    @tutorial = Tutorial.new
    set_current_user_id
    get_original_categories
  end

  def edit
  end

  def create
    @tutorial = Tutorial.new(e_sal_tutorial_params)
    respond_to do |format|
      if @tutorial.save
        format.html { redirect_to e_sal_tutorials_path, notice: 'Tutorial was successfully created.' }
      else
        get_original_categories
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @tutorial.update(e_sal_tutorial_params)
        format.html { redirect_to @e_sal_tutorial, notice: 'Tutorial was successfully updated.' }
        format.json { render :show, status: :ok, location: @e_sal_tutorial }
      else
        format.html { render :edit }
        format.json { render json: @e_sal_tutorial.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tutorial.destroy
    respond_to do |format|
      format.html { redirect_to e_sal_tutorials_url, notice: 'Tutorial was successfully destroyed.' }
      format.json { head :no_content }
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
