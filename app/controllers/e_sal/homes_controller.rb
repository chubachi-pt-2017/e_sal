class ESal::HomesController < ESal::Base
  
  def index
    
    @user = User.find(current_user.id)
    
    @timelines = PublicActivity::Activity.where(
      "trackable_type not in(?, ?)",
      "User",
      "ProgrammingAnswer"
      ).order(created_at: :desc).limit(10)
      
    @activities = PublicActivity::Activity.where(
      "owner_id = ? or recipient_id = ?",
      @user.id, @user.id
      ).order(created_at: :desc).limit(10)
      
  end
end
