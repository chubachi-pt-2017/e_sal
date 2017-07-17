class TutorialContent < ApplicationRecord
  has_one :tutorial

  # validates :body,
  # presence: { message: "チュートリアル本文を入力してください。"}
  # if: :published?
end
