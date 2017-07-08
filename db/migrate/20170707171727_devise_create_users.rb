class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              limit: 128, null: false, default: ""
      t.string :encrypted_password, limit: 256, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token, limit: 64
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip, limit: 64
      t.string   :last_sign_in_ip, limit: 64

      ## Confirmable
      t.string   :confirmation_token, limit: 64
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token, limit: 64 # Only if unlock strategy is :email or :both
      t.datetime :locked_at
      
      ## E-sal Original
      t.string   :student_id, limit: 8, null: false, default: ""
      t.string   :user_name,  limit: 64, null: false, default: ""
      t.string   :second_email, limit: 128, null: false, default: ""
      t.integer  :course_type, limit: 1, null: false, default: 0
      t.integer  :age,        limit: 1, null: false, default: 2
      t.integer  :gender,     limit: 1, null: false, default: 0
      t.integer  :job,        limit: 1, null: false, default: 0
      t.string   :job_desc,   limit: 64
      t.boolean  :term_flg,   null: false, default: false
      t.boolean  :deleted_flg, null: false, default: false
      t.datetime :deleted_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
    add_index :users, :student_id,           unique: true
    add_index :users, :second_email,         unique: true
  end
end
