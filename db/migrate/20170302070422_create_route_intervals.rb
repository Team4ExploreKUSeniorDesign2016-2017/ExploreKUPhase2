class CreateRouteIntervals < ActiveRecord::Migration
  def change
    create_table :route_intervals do |t|
      t.decimal :start_time
      t.decimal :end_time
      t.decimal :delta_time
      t.references :route, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
