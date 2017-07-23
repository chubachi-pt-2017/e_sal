class Comment < ApplicationRecord
  belongs_to :tutorial
  belongs_to :user
  
  validates :body, presence: true
end
