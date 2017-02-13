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
end
