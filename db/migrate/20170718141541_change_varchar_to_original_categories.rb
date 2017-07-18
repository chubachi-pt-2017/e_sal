class ChangeVarcharToOriginalCategories < ActiveRecord::Migration[5.0]
  def change
    change_column :original_categories, :name, :string, null: false, unique: true
    change_column :original_categories, :name_url, :string, null: false, unique: true    
  end
end
