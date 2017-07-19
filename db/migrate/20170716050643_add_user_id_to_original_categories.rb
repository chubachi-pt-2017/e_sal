class AddUserIdToOriginalCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :original_categories, :user_id, :integer, null: false, after: :main_category_id
    add_index :original_categories, :user_id
  end
end
