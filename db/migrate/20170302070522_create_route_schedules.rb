class CreateRouteSchedules < ActiveRecord::Migration
  def change
    create_table :route_schedules do |t|
      t.string :info
      t.references :route, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
