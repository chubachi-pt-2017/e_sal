class MainCategory < ApplicationRecord
  has_one :original_category

  scope :all_ids_and_name, -> {
    select("id, name")
  }
end
