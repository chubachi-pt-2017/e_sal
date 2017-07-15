class CreateOriginalCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :original_categories do |t|
      t.string :name, limit: 20, null: false
      t.string :url, limit: 20, null:false
      t.references :main_category, null: false, index: true
      t.timestamps
    end
  end
end
