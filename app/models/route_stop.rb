class RouteStop < ActiveRecord::Base
  belongs_to :route
  belongs_to :bus_stop

  def arrival_times
    if shift == 'Alternate'
      deltas = self.route.route_intervals.where(schedule: self.schedule).pluck(:delta_time)
      i = 0
      time = self.start_time
      times = [time]
      while time < self.end_time
        time += deltas[i % deltas.size]*60
        times << time
        i += 1
      end
    else
      delta = self.route.route_intervals.where("shift = ? and schedule = ?", self.shift, self.schedule).first.delta_time
      times = (self.start_time..self.end_time).step(delta*60)
    end
    times.map do |time|
      (Time.now.at_beginning_of_day + time.seconds).strftime("%I:%M %p")
    end
  end
end
