class CreateOriginalCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :original_categories do |t|
      t.string :name, limit: 20, null: false
      t.string :name_url, limit: 20, null:false
      t.references :main_category, null: false, index: true
      t.timestamps
    end
    add_index :original_categories, :name, unique: true
    add_index :original_categories, :name_url, unique: true
  end
end
