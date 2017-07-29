class Programming < ApplicationRecord

  belongs_to :user
  has_many :programming_answers, dependent: :destroy
  
  validates :title, presence: true, length: {maximum: 128}
  validates :question_desc, presence: true
  
  # public_activity
  include PublicActivity::Common
  
  # activerecord-confirmable
  include ActiveRecord::Confirmable
  
  class << self
    def get_list(user_id, status)
      case status
      when "draft", "answered"
        Programming.includes(:programming_answers).where(programming_answers: {user_id: user_id, answer_status: status})
          .references(:programming_answers)
      when "not_answered"
        Programming.where(ProgrammingAnswer
          .where("programming_answers.user_id = ? and programming_answers.programming_id = programmings.id", user_id)
          .exists.not)
      when "own"
        Programming.where(user_id: user_id)
      else
        Programming.all
      end
    end
  end

end
