class MainCategory < ApplicationRecord
  has_many :original_categories
  has_many :tutorials, through: :original_categories

  scope :all_ids_and_name, -> {
    select("id, name")
  }
  
  scope :get_side_list, -> {
    includes([original_categories: :tutorials])
    .select("count(original_categories.main_category_id), main_categories.name")
    .where("tutorials.status = ?", Tutorial.get_published_id)
    .references(:tutorials, :original_categories, :main_categories)
    .order("count(original_categories.main_category_id) desc")
    .group("main_categories.name")
    .limit(5)
  }
end
