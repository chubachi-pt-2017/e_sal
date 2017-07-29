class ESal::CommentsController < ESal::Base
  before_action :set_tutorial

  def create
    unless current_user
      flash[:alert] = "ログインしてください。"
      redirect_to root_path
    else
      @comment = @tutorial.comments.build(comment_params)
      @comment.user = current_user
      
      if @comment.save
        flash[:notice] = "コメントが投稿されました。"
        redirect_to e_sal_tutorial_path(@tutorial) and return
      else
        @comments = @tutorial.comments
        flash[:alert] = "コメント投稿に失敗しました。エラー内容はコメント記入欄の下のメッセージをご確認ください。"
        render "e_sal/tutorials/show" and return
      end
    end
  end
  
  private
    def comment_params
      params.require(:comment).permit(:body)
    end
    
    def set_tutorial
      @tutorial = Tutorial.find(params[:tutorial_id])
    end
end
