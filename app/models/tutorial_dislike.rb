class TutorialDislike < ApplicationRecord
  belongs_to :user
  belongs_to :tutorial
end
