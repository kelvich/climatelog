class StatsController < ApplicationController

  def index
    current_hour = DateTime.now.hour
    @hours = current_hour.
      downto(current_hour-23).
      map{|h| h%24 }.
      reverse

    temps = Measurement.
      group('EXTRACT(HOUR FROM created_at)::int').
      order('EXTRACT(HOUR FROM created_at)::int').
      average(:temperature)

    @values = @hours.
      map{ |h| @temps[ (h-3)%24 ].to_f }

  end

end
