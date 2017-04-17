class ParkingLot < ActiveRecord::Base
  has_one :location, as: :locatable, :dependent => :destroy
  has_many :parking_exceptions
  accepts_nested_attributes_for :parking_exceptions, :allow_destroy => true
end
