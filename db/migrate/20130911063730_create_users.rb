class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :phone_number, null: false
      t.string :name, null: false
      t.string :session_token

      t.timestamps
    end
    add_index :users, :phone_number, unique: true
  end
end
