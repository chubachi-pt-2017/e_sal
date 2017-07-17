class CreateTutorials < ActiveRecord::Migration[5.0]
  def change
    create_table :tutorials do |t|
      t.string :title, null: false, limit: 64
      t.references :user, index: true
      t.references :original_category, index: true
      t.references :tutorial_content, index: true
      t.column :status, :tinyint, null: false, default: 0
      t.column :comment_enable_flg, :tinyint, default: 0
      t.timestamps
    end
    add_index :tutorials, :title, unique: true
  end
end