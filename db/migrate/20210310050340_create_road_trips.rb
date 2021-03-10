class CreateRoadTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :road_trips do |t|
      t.string :start
      t.string :destination
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
