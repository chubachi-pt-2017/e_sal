class ChangeConstraintToUsers < ActiveRecord::Migration[5.0]
  def change
    ## E-sal Original
    change_column_null :users, :second_email,  null: true

    remove_index :users, column: :second_email
    add_index :users, :second_email,  unique: false
  end
end

