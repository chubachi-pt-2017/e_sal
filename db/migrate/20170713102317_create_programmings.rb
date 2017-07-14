class CreateProgrammings < ActiveRecord::Migration[5.0]
  def change
    create_table :programmings do |t|
      t.string :title, limit: 128, null: false
      t.text :question_desc, null: false
      t.text :correct_answer
      t.references :user, null: false, index: true

      t.timestamps
    end
    add_index :programmings, :title, unique: true
  end
end
