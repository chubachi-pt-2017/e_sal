class RenameLikesToTutorialLikes < ActiveRecord::Migration[5.0]
  def change
    rename_table :likes, :tutorial_likes
  end
end
