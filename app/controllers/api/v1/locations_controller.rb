class Api::V1::LocationsController < ApplicationController
  respond_to :json

  def index
    lat = params[:lat]
    lng = params[:lng]
    distance = params[:distance] || :distance
    sort_by = params[:sort_by]
    count = params[:count]
    type = params[:type]
    keyword = params[:keyword]
    begin
      locations = Location.proximity(lat, lng, distance)
      locations = locations.where(locatable_type: type) unless type.nil?
      if keyword
        keyword = keyword.downcase
        if type != "ParkingLot" && type != "BusStop"
          condition = ActiveRecord::Base.send(:sanitize_sql_array, ["lower(name) like ? OR (locatable_type = 'Building' AND lower(buildings.description) like ?)", "%#{keyword}%", "%#{keyword}%"])
          locations = locations.joins("LEFT JOIN buildings ON locatable_id = buildings.id").where(condition)
        else
          locations = locations.where("lower(name) like ?", "%#{keyword}%")
        end
      end
      respond_with locations.order(sort_by).limit(count).as_json(:except => [:locatable_id, :locatable, :created_at, :updated_at])
    rescue
      respond_with JSON.generate({:error => "Some parameters are invalid!"})
    end
    # ?lat=38.960401&lng=-95.242294&distance=2
  end

  def show
    location = Location.find(params[:id])
    locatable = location.locatable.as_json(:except => [:created_at, :updated_at])
    if location.locatable_type == "Building"
      amenities = location.locatable.amenities.as_json(:except => [:building_id, :created_at, :updated_at])
      departments = location.locatable.departments.as_json(:except => [:building_id, :created_at, :updated_at])
      locatable = locatable.merge(amenities: amenities, departments: departments)
    elsif location.locatable_type == "BusStop"
      arrival_times = location.locatable.get_arrival_times.as_json
      locatable = locatable.merge(arrival_times: arrival_times)
    end
    respond_with location.as_json(:except => [:locatable_id, :created_at, :updated_at]).merge(locatable: locatable)
  end
end
