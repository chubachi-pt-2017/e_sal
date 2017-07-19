class ChangeVarchar20ToVarchar30ToOriginalCategories < ActiveRecord::Migration[5.0]
  def change
    change_column :original_categories, :name_url, :string, null: false, unique: true, limit: 30
  end
end
