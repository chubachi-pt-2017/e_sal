class ESal::TutorialLikesController < ESal::Base
  before_action :likes_params,
                :find_like, only: [:destroy]
  def create
    return if params[:tutorial_id].blank? || params[:user_id].blank?

    if TutorialLike.create(tutorial_id: params[:tutorial_id], user_id: params[:user_id])
      render :text => "success", :status => 200 and return
    else
      render :text => "error", :status => 500 and return
    end
  end
  
  def destroy
    if @like.destroy
      render :text => "success", :status => 200 and return
    else
      render :text => "error", :status => 500 and return
    end
  end
  
  private
    def likes_params
      params.fetch(:like, {}).permit(:tutorial_id, :user_id)
    end
    
    def find_like
      @like = TutorialLike.find_by(tutorial_id: params[:tutorial_id], user_id: params[:user_id])
    end
end