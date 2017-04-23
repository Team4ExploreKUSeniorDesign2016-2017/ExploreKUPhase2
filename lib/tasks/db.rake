require 'csv'
namespace :db do
  desc "import data from files to database"
  task import: :environment do
    puts 'Importing Building'
    file_name = 'db/Building.csv'
	  CSV.foreach(file_name, encoding:'windows-1250:utf-8', headers: true) do |row|
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
  	CSV.foreach(file_name, encoding:'windows-1250:utf-8', headers: true) do |row|
  		loc = Location.create!(name: row['name'], latitude: row['latitude'], longitude: row['longitude'], altitude: row['altitude'], locatable: ParkingLot.create!(lot: row['lot'], restrictions: row['restrictions'],
        Gold: row['Gold'], Blue: row['Blue'], Red: row['Red'], Yellow: row['Yellow'],
        DaisyHill: row['Daisy Hill'], GSPCorbin: row['GSP/Corbin'], OliverMcCarthyHalls: row['Oliver/McCarthy Halls'], AlumniPlace: row['Alumni Place'], JayhawkTowers: row['Jayhawk Towers'], SunflowerApartments: row['Sunflower Apartments'],
        Handicap: row['Handicap'], Meter: row['Meter'], PF: row['PF'], Load: row['Load'], Reserved: row['Reserved'], Service: row['Service'], State: row['State'], Other: row['Other'], Total: row['Total'], Cycle: row['Cycle']))
      if row['exceptions']
        tmp = row['exceptions'].split('|')
        tmp.each do |exception|
          loc.locatable.parking_exceptions.create(description: exception)
        end
      end
  	end

    puts 'Importing Bus Stop'
    file_name = 'db/BusStop.csv'
  	CSV.foreach(file_name, headers: true) do |row|
  		Location.create!(name: row['name'], latitude: row['latitude'], longitude: row['longitude'],  altitude: row['altitude'], locatable: BusStop.create!(number: row['number']))
  	end
    puts 'Importing Route'
    file_name = 'db/Route.csv'
    CSV.foreach(file_name, headers: true) do |row|
      Route.create!(name: row['name'], number: row['number'], end: row['end'])
    end
    puts 'Importing Route Interval'
    file_name = 'db/RouteInterval.csv'
    CSV.foreach(file_name, headers: true) do |row|
      route = Route.where(number: row['route_number']).first
      RouteInterval.create!(delta_time: row['delta_time'], shift: row['shift'], schedule: row['schedule'], route: route)
    end
    puts 'Importing Route Stop'
    file_name = 'db/RouteStop.csv'
    CSV.foreach(file_name, headers: true) do |row|
      bus_stop = BusStop.where(number: row['stop_number']).first
      route = Route.where(number: row['route_number']).first
      start_time = Time.parse(row['start_time']).seconds_since_midnight
      end_time = Time.parse(row['end_time']).seconds_since_midnight
      end_time += 24.hours if end_time <= Time.parse("3 AM").seconds_since_midnight
      RouteStop.create!(route: route, bus_stop: bus_stop, start_time: start_time, end_time: end_time, shift: row['shift'], schedule: row['schedule'], line: row['line'])
    end
  end
end
