class TutorialDislike < ApplicationRecord
  belongs_to :user
  belongs_to :tutorial
  
  class << self
    def get_number_of_dislikes(tutorial_id)
      where(tutorial_id: tutorial_id).count
    end

    def disliked?(user_id, tutorial_id)
      result = where(user_id: user_id, tutorial_id: tutorial_id)
      return true if result.present?
      false
    end
  end
end
