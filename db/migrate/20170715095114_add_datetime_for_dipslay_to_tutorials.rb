class AddDatetimeForDipslayToTutorials < ActiveRecord::Migration[5.0]
  def change
    add_column :tutorials, :datetime_for_display, :datetime, after: :comment_enable_flg
  end
end
