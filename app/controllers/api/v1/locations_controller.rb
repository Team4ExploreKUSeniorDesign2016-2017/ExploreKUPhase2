class Api::V1::LocationsController < ApplicationController
  respond_to :json

  def index
    lat = params[:lat]
    lng = params[:lng]
    distance = params[:distance]
    respond_with Location.proximity(lat, lng, distance).as_json(:except => [:locatable_id, :locatable, :created_at, :updated_at])
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
