class TutorialLike < ApplicationRecord
  belongs_to :user
  belongs_to :tutorial
end
