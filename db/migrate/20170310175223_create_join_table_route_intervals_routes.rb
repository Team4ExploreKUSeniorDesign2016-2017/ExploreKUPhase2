class CreateJoinTableRouteIntervalsRoutes < ActiveRecord::Migration
  def change
    create_join_table :route_intervals, :routes do |t|
      t.index [:route_interval_id, :route_id]
      t.index [:route_id, :route_interval_id]
    end
  end
end
