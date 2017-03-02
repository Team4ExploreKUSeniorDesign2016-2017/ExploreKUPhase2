class RouteStop < ActiveRecord::Base
  belongs_to :route
  belongs_to :bus_stop
end
