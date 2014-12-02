class StatsController < ApplicationController

  def index
    @temperature = Measurement.last_day(:temperature)
    @humidity = Measurement.last_day(:humidity)
    

    # convert to millimeters of mercury
    pressure = Measurement.last_day(:pressure)
    @pressure = Hash[pressure.map{ |h,p| [h, p/133.3] }]

    @devices = Device.all
  end

  def show
    dev = Device.find(params[:id])
    @temp = dev.measurements.by_hours("temperature")
    @humidity = dev.measurements.by_hours("humidity")
    @pressure = dev.measurements.by_hours("pressure")
  end

end
