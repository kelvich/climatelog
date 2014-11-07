class SensorController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:receive]

  def receive
    render :json => Measurement.create(measurement_params)
  end

  private

    def measurement_params
      params.permit(:temperature,:pressure,:humidity,:mac)
    end

end
