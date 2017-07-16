class OriginalCategory < ApplicationRecord
  has_one :tutorial
  belongs_to :main_category

  class << self
    def get_by_user_id(user_id)
      where(user_id: user_id).order(id: :asc)
    end
  end
end
