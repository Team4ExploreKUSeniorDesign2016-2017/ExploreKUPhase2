class CreateRouteStops < ActiveRecord::Migration
  def change
    create_table :route_stops do |t|
      t.decimal :start_time
      t.decimal :end_time
      t.string :shift
      t.string :schedule
      t.string :line
      t.references :route, index: true, foreign_key: true
      t.references :bus_stop, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
