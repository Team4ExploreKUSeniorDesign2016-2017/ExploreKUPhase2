class Route < ActiveRecord::Base
  has_many :route_stops
  has_many :bus_stops, :through => :route_stops
  has_and_belongs_to_many :route_intervals
end
