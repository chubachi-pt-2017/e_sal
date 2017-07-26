class CreateProgrammingAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :programming_answers do |t|
      t.integer :programming_language, limit: 1, null: false, default: 1
      t.text :answer_code, null: false
      t.text :answer_result, null: false
      t.integer :answer_status, limit: 1, null: false, default: 0
      t.integer :tab_size, limit: 1, null: false, default: 2
      t.references :programming, null: false, index: true
      t.references :user, null: false, index: true

      t.timestamps
    end
    add_index :programming_answers, [:programming_id, :user_id], unique: true
  end
end
