class AddAttachmentImageToPhotos < ActiveRecord::Migration[5.0]
  def self.up
    change_table :photos do |t|
      t.has_attached_file :image, :after => :id
    end
  end
 
  def self.down
    drop_attached_file :photos, :image
  end
end