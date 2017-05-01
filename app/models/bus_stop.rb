class BusStop < ActiveRecord::Base
  has_one :location, as: :locatable, :dependent => :destroy
  has_many :route_stops, :dependent => :destroy
  has_many :routes, :through => :route_stops
  accepts_nested_attributes_for :route_stops, :allow_destroy => true

  def get_arrival_times
    arrival_times = Hash.new { |h, k| h[k] = { } }
    self.route_stops.each do |s|
      key = s.line ? s.line : s.schedule
      arrival_times[s.route.number][key] = [arrival_times[s.route.number][key], s.arrival_times].compact.reduce([], :|)
    end
    arrival_times
  end
end
