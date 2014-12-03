class Measurement < ActiveRecord::Base

  def self.last_day(quantity)
    current_hour = DateTime.now.hour
    hours = current_hour.
      downto(current_hour-23).
      map{|h| h%24 }.
      reverse

    temps = Measurement.
      group('EXTRACT(HOUR FROM created_at)::int').
      order('EXTRACT(HOUR FROM created_at)::int').
      average(quantity)

    values = hours.
      map{ |h| temps[ (h-3)%24 ].to_f }

    Hash[hours.zip(values)]
  end

  def self.by_hours(quantity)
    pairs = Measurement.
      group("date_trunc('hour',measured_at)").
      order("date_trunc('hour',measured_at)"). 
      pluck("extract(epoch from date_trunc('hour',measured_at)), avg(#{quantity})").
      map{ |t| [t.first.to_i*1000,t.last.round(2)] if t.last!=nil }.
      compact

    #fill with NaN's
    t1 = pairs.first.first
    t2 = pairs.last.first
    ts = (t1..t2).step(3600000).to_a

    pairs = Hash[pairs]
    ts.map{ |t| [t, pairs[t]] }
  end

end


1417539600000