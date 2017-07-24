class CreateTutorialDislikes < ActiveRecord::Migration[5.0]
  def change
    create_table :tutorial_dislikes do |t|
      t.references :user, foreign_key: true, null: false
      t.references :tutorial, foreign_key: true, null: false

      t.timestamps
    end
  end
end
