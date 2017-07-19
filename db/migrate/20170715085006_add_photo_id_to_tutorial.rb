class AddPhotoIdToTutorial < ActiveRecord::Migration[5.0]
  def change
    add_column :tutorials, :photo_id, :integer, after: :user_id
    add_index :tutorials, :photo_id
  end
end
