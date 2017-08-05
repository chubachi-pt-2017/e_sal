class ESal::HomesController < ESal::Base
  
  def index
    
    @timelines = PublicActivity::Activity.where(
      "trackable_type not in(?, ?)",
      "User",
      "ProgrammingAnswer"
      ).order(created_at: :desc).limit(10)
      
    @activities = PublicActivity::Activity.where(
      "owner_id = ? or recipient_id = ?",
      current_user.id, current_user.id,
      ).order(created_at: :desc).limit(10)
    
    @pie_course_types = User.get_pie_course_types
    
    @programming_answers = ProgrammingAnswer.has_draft(current_user.id)
    
    @tutorials = Tutorial.has_draft(current_user.id)
      
  end
end
