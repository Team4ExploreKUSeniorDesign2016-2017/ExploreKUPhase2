class Api::V1::LocationsController < ApplicationController
  respond_to :json

  def show
    location = Location.find(params[:id])
    locatable = location.locatable.as_json(:except => [:created_at, :updated_at])
    if location.locatable_type == "Building"
      amenities = location.locatable.amenities.as_json(:except => [:building_id, :created_at, :updated_at])
      departments = location.locatable.departments.as_json(:except => [:building_id, :created_at, :updated_at])
      locatable = locatable.merge(amenities: amenities, departments: departments)
      respond_with location.as_json(:except => [:locatable_id, :created_at, :updated_at]).merge(locatable: locatable) 
    elsif location.locatable_type == "ParkingLot"
       respond_with location.as_json(:except => [:lot_id, :created_at, :updated_at]).merge(locatable: locatable)
    else location.locatable_type == "BusStop"
      routes = location.locatable.routes.as_json(:except => [:bus_id, :created_at, :updated_at])
      locatable = locatable.merge(routes: routes)
      respond_with location.as_json(:except => [:locatable_id, :created_at, :updated_at, :routeAssignments]).merge(locatable: locatable)
    end
  end
end
