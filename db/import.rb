# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

CSV.foreach('db/backup.csv') do |row|
	if (row[3] == 'Building') then
		Location.create!(name: row[0], latitude: row[1], longitude: row[2], locatable: Building.create!(description: row[5], address: row[6]))
	elsif (row[3] == 'ParkingLot') then
		Location.create!(name: row[0], latitude: row[1], longitude: row[2], locatable: ParkingLot.create!(status: row[5]))
	elsif (row[3] == 'BusStop') then
		Location.create!(name: row[0], latitude: row[1], longitude: row[2], locatable: BusStop.create!(number: row[5]))
	elsif (row[3] == 'Amenity') then
		#@building = Building.where(id: row[0])
		Amenity.create!(building_id: row[0], name: row[1])
	elsif (row[3] == 'Department') then
		Department.create!(building_id: row[0], name: row[1])
	elsif (row[3] == 'RouteAssignment') then
		RouteAssignment.create!(bus_stop_id: row[0], route_id: row[1])
	elsif (row[3] == 'Route') then
		Route.create!(number: row[0], name: row[1], direction: row[2])
	end
end
