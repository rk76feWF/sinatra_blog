class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do|t|
      t.string :user_email
      t.string :password_digest
      t.string :user_name
      t.string :profile_img
      t.timestamps null: false
    end
  end
end
