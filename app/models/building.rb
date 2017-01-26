class Building < ActiveRecord::Base
  has_one :location, as: :locatable, :dependent => :destroy
  has_many :amenities, dependent: :destroy
  has_many :departments, dependent: :destroy
end
