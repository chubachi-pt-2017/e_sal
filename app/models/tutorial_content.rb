class TutorialContent < ApplicationRecord
  belongs_to :tutorial

  # validates :body,
  # presence: { message: "チュートリアル本文を入力してください。"},
  # if: Tutorial.published?
end
