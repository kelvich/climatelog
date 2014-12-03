class StatsController < ApplicationController

  def index
    @devices = Device.order(:mac).all
  end

  def show
    dev = Device.find(params[:id])
    @temp = dev.measurements.by_hours("temperature")
    @humidity = dev.measurements.by_hours("humidity")
    @pressure = dev.measurements.by_hours("pressure")
  end

end
