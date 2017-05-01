class Route < ActiveRecord::Base
  has_many :route_stops
  has_many :bus_stops, :through => :route_stops
  has_many :route_intervals

  accepts_nested_attributes_for :route_intervals, :allow_destroy => true
end
