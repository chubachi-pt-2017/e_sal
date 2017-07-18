class ESal::OriginalCategoriesController < ESal::Base
  before_action :set_original_category, only: [:show, :edit, :update, :destroy]

  def index
    @original_categories = OriginalCategory.get_by_user_id(current_user.id).page(params[:page]).per(LIST_NUM_PER_PAGE)
  end

  def new
    @original_category = OriginalCategory.new
    set_current_user_id
    get_all_main_categories
  end

  def edit
    get_all_main_categories
    has_tutorials
  end

  def create
    @original_category = OriginalCategory.new(original_category_params)

    respond_to do |format|
      if @original_category.save
        format.html { redirect_to action: :index, notice: "「#{@original_category.name}」カテゴリを作成しました。" }
      else
        get_all_main_categories
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @original_category.update(original_category_params)
        format.html { redirect_to action: :index, notice: "「#{@original_category.name}」カテゴリをアップデートしました。" }
      else
        get_all_main_categories
        has_tutorials
        format.html { render :edit }
      end
    end
  end

  def destroy
    deleted_category = @original_category.name
    if @original_category.destroy
      message = "「#{deleted_category}」カテゴリを削除しました。"
    else
      message = "「#{deleted_category}」カテゴリの削除に失敗しました。"
    end

    respond_to do |format|
      format.html { redirect_to action: :index, notice: message }
    end
  end

  private
    def set_original_category
      @original_category = OriginalCategory.find(params[:id])
    end

    def original_category_params
      params.fetch(:original_category, {}).permit(:name, :name_url, :main_category_id, :user_id, :created_at)
    end

    def set_current_user_id
      @original_category.user_id = get_current_user_id
    end
    
    def get_all_main_categories
      @main_categories = MainCategory.all_ids_and_name
    end

    # 既にチュートリアルにオリジナルカテゴリが使用されていたら編集できないようにする。
    def has_tutorials
      @has_tutorials = Tutorial.has_tutorials?(@original_category.id)
    end
end
