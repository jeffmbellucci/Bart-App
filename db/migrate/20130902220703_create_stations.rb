class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :abbr
      t.string :name

      t.timestamps
    end
  end
end
