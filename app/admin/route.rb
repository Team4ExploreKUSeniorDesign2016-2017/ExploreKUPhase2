ActiveAdmin.register Route do
  permit_params :number, :name, :end, route_intervals_attributes: [:id, :delta_time, :shift, :schedule]
  form do |f|
    f.inputs 'Route' do
      f.input :number
      f.input :name
      f.input :end
      f.has_many :route_intervals, allow_destroy: true, new_record: "Add Intervals" do |e|
        e.input :delta_time, label: "Delta time (minutes)"
        e.input :shift
        e.input :schedule
      end
    end
    f.actions
  end
end
