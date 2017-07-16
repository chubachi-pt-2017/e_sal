class OriginalCategory < ApplicationRecord
  has_one :tutorial
  
  class << self
    def get_by_user_id(user_id)
      where(user_id: user_id).order(id: :asc)
    end
  end
end
