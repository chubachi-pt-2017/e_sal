class ESal::TutorialDislikesController < ESal::Base
  before_action :dislikes_params,
                :find_dislike, only: [:destroy]

  def create
    return if params[:tutorial_id].blank? || params[:user_id].blank?

    if TutorialDislike.create(tutorial_id: params[:tutorial_id], user_id: params[:user_id])
      render :text => "success", :status => 200 and return
    else
      render :text => "error", :status => 500 and return
    end
  end
  
  def destroy
    if @dislike.destroy
      render :text => "success", :status => 200 and return
    else
      render :text => "error", :status => 500 and return
    end
  end
  
  private
    def dislikes_params
      params.fetch(:like, {}).permit(:tutorial_id, :user_id)
    end
    
    def find_dislike
      @dislike = TutorialDislike.find_by(tutorial_id: params[:tutorial_id], user_id: params[:user_id])
    end
end