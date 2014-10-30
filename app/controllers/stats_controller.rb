class StatsController < ApplicationController

  def index
    @temperature = Measurement.last_day(:temperature)
    @humidity = Measurement.last_day(:humidity)
    

    # convert to millimeters of mercury
    pressure = Measurement.last_day(:pressure)
    @pressure = Hash[pressure.map{ |h,p| [h, p/133.3] }]
  end

end
