class Tutorial < ApplicationRecord

  module Status
    DRAFT = 1
    PUBLISHED = 2

    def self.select_options
      {
        "非公開" => DRAFT,
        "公開" => PUBLISHED
      }
    end
  end

  has_one :tutorial_content
  belongs_to :original_category
  accepts_nested_attributes_for :tutorial_content

  def tutorial_status
    return Status::PUBLISHED if published?
    Status::DRAFT
  end

  def published?
    status == Status::PUBLISHED
  end
end
