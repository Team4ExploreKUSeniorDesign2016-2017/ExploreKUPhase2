ActiveAdmin.register Location do

  permit_params :name, :latitude, :longitude, :altitude, :locatable_type, :locatable_id,
    locatable_attributes: [:id, :number, :status, :description, :address, :image,
      amenities_attributes: [:id, :name, :_destroy],
      departments_attributes: [:id, :name, :_destroy],
      route_stops_attributes: [:id, :route_id, :start_time, :end_time, :shift, :schedule, :line]]

  form do |f|
    css_class = f.object.locatable ? "inputs" : "inputs polyform"

    f.inputs 'Location' do
      f.input :name
      f.input :latitude
      f.input :longitude
      f.input :altitude
      if !f.object.locatable
        f.input :locatable_type, input_html: {class: 'polyselect'},
        collection: Location::LOCATABLE_TYPES
      end
    end

    if f.object.locatable_type != 'Building' && f.object.locatable_type != 'BusStop'
      f.inputs 'Parking Lot', for: [:locatable, f.object.locatable || ParkingLot.new], id: 'ParkingLot_poly', class: css_class do |fc|
        fc.input :lot
        fc.input :Gold
        fc.input :Blue
        fc.input :Red
        fc.input :Yellow
        fc.input :DaisyHill
        fc.input :GSPCorbin
        fc.input :AlumniPlace
        fc.input :OliverMcCarthyHalls
        fc.input :JayhawkTowers
        fc.input :SunflowerApartments
        fc.input :Handicap
        fc.input :Meter
        fc.input :PF
        fc.input :Load
        fc.input :Reserved
        fc.input :Service
        fc.input :State
        fc.input :Other
        fc.input :Total
        fc.input :Cycle
        fc.input :restrictions
        fc.has_many :parking_exceptions, allow_destroy: true, new_record: "Add Exceptions" do |e|
          e.input :description
        end
      end
    end

    if f.object.locatable_type != 'ParkingLot' && f.object.locatable_type != 'BusStop'
      f.inputs 'Building', for: [:locatable, f.object.locatable || Building.new], id: 'Building_poly', class: css_class do |fc|
        fc.input :description
        fc.input :address
        fc.input :image
        fc.has_many :amenities, allow_destroy: true, new_record: "Add Amenities" do |e|
          e.input :name
        end
        fc.has_many :departments, allow_destroy: true, new_record: "Add Departments" do |e|
          e.input :name
        end
      end
    end

    if f.object.locatable_type != 'Building' && f.object.locatable_type != 'ParkingLot'
      f.inputs 'Bus Stop', for: [:locatable, f.object.locatable || BusStop.new], id: 'BusStop_poly', class: css_class do |fc|
        fc.input :number
        fc.has_many :route_stops, allow_destroy: true, new_record: "Add Routes" do |e|
          e.input :route
          e.input :start_time
          e.input :end_time
          e.input :shift
          e.input :schedule
          e.input :line
        end
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
