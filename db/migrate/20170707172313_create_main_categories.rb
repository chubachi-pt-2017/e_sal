class CreateMainCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :main_categories do |t|
      t.string :name, limit: 64, null: false

      t.timestamps
    end
    
    add_index :main_categories, :name, unique: true
  end
end
