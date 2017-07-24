class ESal::TutorialDislikesController < ESal::Base

  def create
    dislikes_params
    if params[:tutorial_id].blank? || params[:user_id].blank?
      redirect_to e_sal_tutorial_path(id: params[:user_id])
      return
    end

    if TutorialDislike.create(tutorial_id: params[:tutorial_id], user_id: params[:user_id])
      render :text => "success", :status => 200 and return
    else
      render :text => "error", :status => 500 and return
    end
  end
  
  def destroy
  end
  
  private
    def dislikes_params
      params.fetch(:like, {}).permit(:tutorial_id, :user_id)
    end
end