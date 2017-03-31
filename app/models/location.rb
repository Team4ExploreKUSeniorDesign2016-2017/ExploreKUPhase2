class Location < ActiveRecord::Base
  belongs_to :locatable, polymorphic: true, :dependent => :destroy

  accepts_nested_attributes_for :locatable, :allow_destroy => true

  LOCATABLE_TYPES = %w(Building ParkingLot BusStop)

  scope :distance, -> (lat, lng) {
    lat = ActiveRecord::Base.connection.quote(lat)
    lng = ActiveRecord::Base.connection.quote(lng)
    select("3959*acos(cos(radians(#{lat}))*cos(radians(latitude))*cos(radians(longitude)-radians(#{lng}))+sin(radians(#{lat}))*sin(radians(latitude))) AS distance, *")
  }

  scope :proximity, -> (lat, lng, distance) {
    where("locations.distance < ?", distance).from(Location.distance(lat, lng), :locations)
  }

  def build_locatable(params)
    raise "Unknown locatable_type: #{locatable_type}" unless LOCATABLE_TYPES.include?(locatable_type)
    self.locatable = locatable_type.constantize.new(params)
  end
end
