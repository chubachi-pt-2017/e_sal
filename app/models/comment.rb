class Comment < ApplicationRecord
  belongs_to :tutorial
  belongs_to :user
  
  validates :body,
  presence: { message: "コメントを入力してください。" },
  length: { maximum: 200, message: "最大文字数は200文字です。" }
end
