class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.datetime :runtime
      t.string :direction
      t.string :station
      t.integer :user_id

      t.timestamps
    end
  end
end
