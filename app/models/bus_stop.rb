class BusStop < ActiveRecord::Base
  has_one :location, as: :locatable, :dependent => :destroy
  has_many :route_stops, :dependent => :destroy
  has_many :routes, :through => :route_stops
end
