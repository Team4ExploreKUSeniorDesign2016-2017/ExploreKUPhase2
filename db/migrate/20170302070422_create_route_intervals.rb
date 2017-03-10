class CreateRouteIntervals < ActiveRecord::Migration
  def change
    create_table :route_intervals do |t|
      t.decimal :delta_time
      t.string :shift
      t.string :schedule

      t.timestamps null: false
    end
  end
end
