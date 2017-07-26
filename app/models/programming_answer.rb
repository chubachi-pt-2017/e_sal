class ProgrammingAnswer < ApplicationRecord
  
  belongs_to :programming
  belongs_to :user
  
  enum programming_language: {
    coffee: 1, c_cpp: 2, csharp: 3, golang: 4, haskell: 5, java: 6, javascript: 7, php: 8, python: 9, ruby: 10,
    rust: 11, swift: 12}
  enum answer_status: { draft: 0, answered: 1 }
  enum tab_size: { "2"=> 2, "3"=> 3, "4"=> 4, "8"=> 8 }
  
  validates :answer_code, presence: { message: "を入力してください"}
  validates :answer_result, presence: { message: "は必須です"}
  
  scope :others, ->(user_id, programming_id) { answered.includes([:user, :programming]).where(
    "user_id != ? and programming_id = ?", user_id, programming_id) }
  scope :desc_new, -> { order(updated_at: :desc) }
  
  class << self
    def has_answered?(user_id, programming_id)
      answer = ProgrammingAnswer.answered.where({programming_id: programming_id, user_id: user_id}).count
      return true if answer > 0
      false
    end
  end
end
