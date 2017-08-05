class User < ApplicationRecord
  
  has_many :programmings
  has_many :programming_answers
  has_many :tutorials
  has_many :tutorial_likes
  has_many :tutorial_dislike

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  enum course_type: { technical_specialist: 0, system_architect: 1, service_manager: 2, strategist: 3, project_manager: 4, business_architect: 5 }
  enum age: { teens: 0, twenties: 1, thirties: 2, forties: 3, fifties: 4, sixties: 5 }
  enum gender: { male: 0, female: 1 }
  enum job: { None: 0, OP: 1, PG: 2, SE: 3, SA: 4, SC: 5, PL: 6, PM: 7, another: 99 }
  
  # activerecord-confirmable
  include ActiveRecord::Confirmable
  
  # public_activity
  include PublicActivity::Common

  VALID_EMAIL_AIIT = /\A[\w+\-.]+@aiit.ac.jp/i
  validates :email,
            length: { maximum: 128 },
            format: { with: VALID_EMAIL_AIIT, message: "はAIITのメールアドレスのみ利用可能です。" }
  
  with_options if: :confirmed? do |confirm|
    confirm.validates :student_id,
              presence: true,
              confirmation: true,
              uniqueness: true,
              length: { is: 8 },
              format: { with: VALID_HALF_DIGIT, message: "は半角数字のみで入力してください。" }
    
    confirm.validates :student_id_confirmation,
              presence: true
    
    confirm.validates :user_name,
              presence: true,
              length: { in: 1..64 }
    
    VALID_EMAIL_NOAIIT = /\A[\w+\-.]+@(?!aiit.ac.jp)/i
    confirm.validates :second_email,
              allow_blank: true,
              length: { maximum: 128 },
              format: { with: VALID_EMAIL_DEFAULT, message: "は有効なメールアドレスではありません。" },
              format: { with: VALID_EMAIL_NOAIIT, message: "はAIITメールアドレスではなく、連絡用に他ドメインのメールアドレスを記入下さい。" }
    
    confirm.validates :job_desc,
              presence: true, if: :is_another?,
              length: { maximum: 64 }
    
    confirm.validate :term_flg_valid?
    
  end
  
  def password_required?
    super if confirmed? && !password_edit_profile
  end
  
  def is_another?
    job == "another"
  end
  
  def term_flg_valid?
    errors.add(:term_flg, "に同意していただかないと登録できません") unless term_flg == true
  end
  
  def password_edit_profile
    validation_context == :profile &&
      password == "" &&
      password_confirmation == ""
  end
  
  class << self
    def get_pie_course_types
      count_all = User.where.not(confirmed_at: nil).count
      User.where.not(confirmed_at: nil).group(:course_type)
        .order(:course_type).count.map { |k, v| {course: User.course_types_i18n.values[User.course_types[k]], 
        count: ((v.to_f / count_all) * 100).round(0)} }
    end
  end

end



