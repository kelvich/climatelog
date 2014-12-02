class SensorController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:receive]

  def receive
    m = Measurement.create(measurement_params)
    m.measured_at = m.created_at
    m.device_id = Device.where(mac:.mac).find_or_create.id
    m.save
    render :json => m
  end

  private

    def measurement_params
      params.permit(:temperature,:pressure,:humidity,:mac)
    end

end
