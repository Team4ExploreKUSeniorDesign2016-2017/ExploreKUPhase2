class Api::V1::LocationsController < ApplicationController
  respond_to :json

  def show
    location = Location.find(params[:id])
    locatable = location.locatable.as_json(:except => [:created_at, :updated_at])
    if location.locatable_type == "Building"
      amenities = location.locatable.amenities.as_json(:except => [:building_id, :created_at, :updated_at])
      departments = location.locatable.departments.as_json(:except => [:building_id, :created_at, :updated_at])
      locatable = locatable.merge(amenities: amenities, departments: departments)
    end
    respond_with location.as_json(:except => [:locatable_id, :created_at, :updated_at]).merge(locatable: locatable) 
  end
end
