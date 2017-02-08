# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
Location.create!(name: "Eaton Hall", latitude: 38.957614, longitude: -95.252717, locatable: Building.create!(address: 'Kansas'))
Location.create!(name: "Learned Hall", latitude: 38.958139, longitude: -95.253385, locatable: Building.create!(address: 'Kansas'))
Location.create!(name: "Jayhawk Tower", latitude: 38.956723, longitude: -95.256004, locatable: Building.create!(address: 'Kansas'))
Location.create!(name: "International Student Services", latitude: 38.958517, longitude: -95.247646, locatable: Building.create!(address: 'Kansas'))
Location.create!(name: "Marvin Hall", latitude: 38.958459, longitude: -95.250232, locatable: Building.create!(address: 'Kansas'))
Location.create!(name: "Dillons Far", latitude: 38.942089, longitude: -95.248488, locatable: Building.create!(address: 'Kansas'))
Location.create!(name: "Lot 33", latitude: 38.958207, longitude: -95.251676, locatable: ParkingLot.create!(status: 'yellow'))
Location.create!(name: "Lot 41", latitude: 38.958274, longitude: -95.254820, locatable: ParkingLot.create!(status: 'red'))
Location.create!(name: "Lot 54", latitude: 38.956514, longitude: -95.252771, locatable: ParkingLot.create!(status: 'green'))
Location.create!(name: "Lot 109", latitude: 38.956447, longitude: -95.256934, locatable: ParkingLot.create!(status: 'blue'))
Location.create!(name: "Lot 101", latitude: 38.956514, longitude: -95.258028, locatable: ParkingLot.create!(status: 'yellow'))
Location.create!(name: "Lot 17 Far", latitude: 38.972866, longitude: -95.235429, locatable: ParkingLot.create!(status: 'yellow'))
Location.create!(name: "Stop 369", latitude: 38.957135, longitude: -95.253834, locatable: BusStop.create!(number: 1))
Location.create!(name: "Stop 370", latitude: 38.957010, longitude: -95.255111, locatable: BusStop.create!(number: 2))
Location.create!(name: "Stop 216", latitude: 38.955900, longitude: -95.253309, locatable: BusStop.create!(number: 3))
Location.create!(name: "Stop 388", latitude: 38.955222, longitude: -95.246949, locatable: BusStop.create!(number: 4))
Location.create!(name: "Stop 380", latitude: 38.955754, longitude: -95.258403, locatable: BusStop.create!(number: 5))
Location.create!(name: "Stop 90 Far", latitude: 38.956917, longitude: -95.279821, locatable: BusStop.create!(number: 5))
