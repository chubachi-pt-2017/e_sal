class AddUserIdToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :user_id, :integer, null: false, after: :image_file_name
    add_index :photos, :user_id
  end
end
