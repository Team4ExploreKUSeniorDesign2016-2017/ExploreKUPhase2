class Location < ActiveRecord::Base
  belongs_to :locatable, polymorphic: true, :dependent => :destroy

  accepts_nested_attributes_for :locatable, :allow_destroy => true

  LOCATABLE_TYPES = %w(Building ParkingLot BusStop)

  scope :proximity, -> (lat, lng, distance) { where("3959*acos(cos(radians(?))*cos(radians(latitude))*cos(radians(longitude)-radians(?))+sin(radians(?))*sin(radians(latitude))) < ?", lat, lng, lat, distance) }

  def build_locatable(params)
    raise "Unknown locatable_type: #{locatable_type}" unless LOCATABLE_TYPES.include?(locatable_type)
    self.locatable = locatable_type.constantize.new(params)
  end
end
