require 'csv'
namespace :db do
  desc "import data from files to database"
  task import: :environment do
    puts 'Importing Building'
    file_name = 'db/Building.csv'
	  CSV.foreach(file_name, headers: true) do |row|
  		loc = Location.create!(name: row['name'], latitude: row['latitude'], longitude: row['longitude'], altitude: row['altitude'], locatable: Building.create!(image: row['image'], description: row['description'], address: row['address']))
  		if row['department']
  			tmp = row['department'].split('|')
  			tmp.each do |department|
  				loc.locatable.departments.create(name: department)
  			end
  		end
  		if row['amenity']
  			tmp = row['amenity'].split('|')
  			tmp.each do |amenity|
  				loc.locatable.amenities.create(name: amenity)
  			end
  		end
  	end
    puts 'Importing Parking Lot'
    file_name = 'db/ParkingLot.csv'
  	CSV.foreach(file_name, headers: true) do |row|
  		Location.create!(name: row['name'], latitude: row['latitude'], longitude: row['longitude'],  altitude: row['altitude'], locatable: ParkingLot.create!(status: row['status']))
  	end
    puts 'Importing Bus Stop'
    file_name = 'db/BusStop.csv'
  	CSV.foreach(file_name, headers: true) do |row|
  		Location.create!(name: row['name'], latitude: row['latitude'], longitude: row['longitude'],  altitude: row['altitude'], locatable: BusStop.create!(number: row['number']))
  	end
    puts 'Importing Route'
    file_name = 'db/Route.csv'
    CSV.foreach(file_name, headers: true) do |row|
      Route.create!(name: row['name'], line: row['line'], number: row['number'])
    end
    puts 'Importing Route Interval'
    file_name = 'db/RouteInterval.csv'
    CSV.foreach(file_name, headers: true) do |row|
      routes = Route.where(number: row['route_number'])
      RouteInterval.create!(delta_time: row['delta_time'], shift: row['shift'], schedule: row['schedule'], routes: routes)
    end
  end
end
