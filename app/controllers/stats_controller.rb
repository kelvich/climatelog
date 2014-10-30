class StatsController < ApplicationController

  def index
    current_hour = DateTime.now.hour
    @labels = current_hour.
      downto(current_hour-24).
      map{|h| h>=0? h: 24+h}.
      reverse

    @temps = Measurement.
      group('EXTRACT(HOUR FROM created_at)').
      order('EXTRACT(HOUR FROM created_at)').
      average(:temperature).
      values.
      map(&:to_f)

  end

end
