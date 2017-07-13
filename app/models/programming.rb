class Programming < ApplicationRecord

  belongs_to :user
  
  validates :title, presence: true, length: {maximum: 128}
  validates :question_desc, presence: true

  # public_activity
  include PublicActivity::Common

end
