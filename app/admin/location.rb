ActiveAdmin.register Location do

  permit_params :name, :latitude, :longitude, :locatable_type, :locatable_id, locatable_attributes: [:status, :description, :address, :image]

  form do |f|
    css_class = f.object.locatable ? "inputs" : "inputs polyform"

    f.inputs 'Location' do
      f.input :name
      f.input :latitude
      f.input :longitude
      if !f.object.locatable
        f.input :locatable_type, input_html: {class: 'polyselect'},
        collection: Location::LOCATABLE_TYPES
      end
    end

    if f.object.locatable_type != 'Building' && f.object.locatable_type != 'BusStop'
      f.inputs 'Parking Lot', for: [:locatable, f.object.locatable || ParkingLot.new], id: 'ParkingLot_poly', class: css_class do |fc|
        fc.input :status
      end
    end

    if f.object.locatable_type != 'ParkingLot' && f.object.locatable_type != 'BusStop'
      f.inputs 'Building', for: [:locatable, f.object.locatable || Building.new], id: 'Building_poly', class: css_class do |fc|
        fc.input :description
        fc.input :address
        fc.input :image
      end
    end

    if f.object.locatable_type != 'Building' && f.object.locatable_type != 'ParkingLot'
      f.inputs 'Bus Stop', for: [:locatable, f.object.locatable || BusStop.new], id: 'BusStop_poly', class: css_class do |fc|
        fc.input :number
      end
    end

    f.actions
  end

  controller do
    def create
      @location = Location.new permitted_params[:location]
      if @location.save
        redirect_to collection_path
      end
    end
  end
end
