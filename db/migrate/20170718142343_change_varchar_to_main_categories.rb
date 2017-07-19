class ChangeVarcharToMainCategories < ActiveRecord::Migration[5.0]
  def change
    change_column :main_categories, :name, :string, null: false, unique: true
    change_column :main_categories, :name_url, :string, null: false, unique: true
  end
end
