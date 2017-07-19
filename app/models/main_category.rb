class MainCategory < ApplicationRecord
  has_many :original_categories
  has_many :tutorials, through: :original_categories

  scope :all_ids_and_name, -> {
    select("id, name")
  }
end
