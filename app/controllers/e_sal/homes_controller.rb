class ESal::HomesController < ESal::Base
  
  def index
    
    @timelines = PublicActivity::Activity.where(
      "trackable_type not in(?, ?)",
      "User",
      "ProgrammingAnswer"
      ).order(created_at: :desc).limit(10)
      
    @activities = PublicActivity::Activity.where(
      "(owner_id = ? or recipient_id) = ? and trackable_type not in(?)",
      current_user.id, current_user.id,
      "Programming"
      ).order(created_at: :desc).limit(10)
      
  end
end
