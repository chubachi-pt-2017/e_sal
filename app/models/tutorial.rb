class Tutorial < ApplicationRecord

  module Status
    DRAFT = 1
    PUBLISHED = 2

    def self.publish_select_options
      {
        "非公開" => DRAFT,
        "公開" => PUBLISHED
      }
    end
  end

  module CommentPermission
    NG = 1
    OK = 2

    def self.comment_select_options
      {
        "許可しない" => NG,
        "許可する" => OK
      }
    end
  end

  belongs_to :tutorial_content
  belongs_to :original_category
  belongs_to :user  
  has_many :comments, dependent: :destroy

  has_one :main_category, through: :original_category
  accepts_nested_attributes_for :tutorial_content, allow_destroy: true  

  validates :title,
  presence: { message: "タイトルを入力してください。" },
  length: { maximum: 30, message: "最大文字数は30文字です。" },
  uniqueness: { message: "入力したタイトルは既に存在します。"}

  validates :original_category_id,
  presence: { message: "カテゴリを選択して下さい。" }

  validates :status,
  presence: { message: "公開/非公開を選択してください。"},
  numericality: { only_integer: true }

  validates :comment_enable_flg,
  numericality: { only_integer: true }

  validates :datetime_for_display,
  presence: { message: "更新日を設定してください。"},
  if: :published?

  validate :need_body_validation, if: :published?

  def need_body_validation
    errors.add(:body, "チュートリアル本文を入力してください。") if tutorial_content.body.blank?
  end


  scope :published_tutorials, -> {
    where(status: Status::PUBLISHED)
    .order(datetime_for_display: :desc)
  }

  def check_status
    return Status::PUBLISHED if published?
    Status::DRAFT
  end

  def published?
    status == Status::PUBLISHED
  end

  def check_comment_permission
    return CommentPermission::OK if approve_comment?
    CommentPermission::NG
  end

  def approve_comment?
    comment_enable_flg == CommentPermission::OK
  end

  def status_for_display
    return '公開中' if published?
    '非公開'
  end

  def comment_permission_for_display
    return '許可する' if approve_comment?
    '許可しない'
  end

  class << self
    def has_tutorials?(original_category_id)
      published_tutorial_num =
      where("tutorials.status = ? and tutorials.original_category_id = ?", Status::PUBLISHED, original_category_id)
      .count

      return true if published_tutorial_num > 0
      false
    end

    def get_by_user_id(user_id)
      includes([original_category: :main_category])
      .where("tutorials.user_id = ?", user_id)
      .order("tutorials.status asc, tutorials.id desc")
    end
  end
end
