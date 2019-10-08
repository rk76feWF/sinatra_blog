class CreateContribution < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do|t|
      t.string :title
      t.string :body
      t.references :user
      t.timestamps null: false
    end
  end
end
