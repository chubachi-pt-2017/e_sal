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

  has_one :tutorial_content
  belongs_to :original_category
  belongs_to :photo
  belongs_to :users
  accepts_nested_attributes_for :tutorial_content, allow_destroy: true

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
end
