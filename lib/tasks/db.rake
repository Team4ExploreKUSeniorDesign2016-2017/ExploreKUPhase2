require 'csv'
namespace :db do
  desc "import data from files to database"
  task import: :environment do
    file_name = 'db/backup.csv'
    CSV.foreach(file_name, headers: true) do |row|
      type = row['locatable_type']
      case type
      when 'Building'
        Location.create!(name: row['name'], latitude: row['latitude'], longitude: row['longitude'], locatable: Building.create!(description: row['description'], address: row['address']))
      when 'ParkingLot'
        Location.create!(name: row['name'], latitude: row['latitude'], longitude: row['longitude'], locatable: ParkingLot.create!(status: row['description']))
      when 'BusStop'
        Location.create!(name: row['name'], latitude: row['latitude'], longitude: row['longitude'], locatable: BusStop.create!(number: row['description']))
      when 'Amenity'
        Amenity.create!(building_id: row['name'], name: row['latitude'])
      when 'Department'
        Department.create!(building_id: row['name'], name: row['latitude'])
      when 'RouteAssignment'
        RouteAssignment.create!(bus_stop_id: row['name'], route_id: row['latitude'])
      when 'Route'
        Route.create!(number: row['name'], name: row['latitude'], direction: row['latitude'])
    	end
    end
  end
  task import_updated: :environment do
    file_name = 'db/Building.csv'
	  CSV.foreach(file_name, headers: true) do |row|
  		loc = Location.create!(name: row['name'], latitude: row['latitude'], longitude: row['longitude'], locatable: Building.create!(image: row['image'], description: row['description'], address: 	row['address']))
  		if row['department'] != 'none'
  			tmp = row['department'].split('|')
  			tmp.each do |department|
  				loc.locatable.departments.create(name: department)
  			end
  		end
  		if row['amenity'] != 'none'
  			tmp = row['amenity'].split('|')
  			tmp.each do |amenity|
  				loc.locatable.amenities.create(name: amenity)
  			end
  		end
  	end
    file_name = 'db/ParkingLot.csv'
  	CSV.foreach(file_name, headers: true) do |row|
  		Location.create!(name: row['name'], latitude: row['latitude'], longitude: row['longitude'], locatable: ParkingLot.create!(status: row['status']))
  	end
    file_name = 'db/BusStop.csv'
  	CSV.foreach(file_name, headers: true) do |row|
  		Location.create!(name: row['name'], latitude: row['latitude'], longitude: row['longitude'], locatable: BusStop.create!(number: row['number']))
  	end
  end
end
