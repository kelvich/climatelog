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
    temps = Measurement.
      group("date_trunc('hour',measured_at)").
      order("date_trunc('hour',measured_at)"). 
      pluck("extract(epoch from date_trunc('hour',measured_at))*1000, avg(#{quantity})").
      map{ |t| [t.first.to_i,t.last.round(2)] if t.last!=nil }.
      compact
  end

end




# curl -v -d '{"inputs":"weather_proxy_1_802857fd9b", "query":[{"link":{"bucket":"weather_proxy_1_802857fd9b"}},{"map":{"language":"javascript","name":"1"}}]}' -H "Content-Type: application/json" http://blackbird.datamol.net:8098/


# curl -XPOST http://blackbird.datamol.net:8098/mapred \
#   -H 'Content-Type: application/json'   \
#   -d '{"inputs":"weather_proxy_1_802857fd9b","query":[{"map":{"language":"javascript","source":"function(v) {
#       var data = JSON.parse(v.values[0].data);
#       return [[data, 1]];
# }"}}]}'


# curl http://blackbird.datamol.net:8098/search/query/weather_proxy_1_802857fd9b?wt=json&q=name_s:*

# curl -XPOST http://blackbird.datamol.net:8098/mapred


# curl 'http://blackbird.datamol.net:8098/types/counters/buckets/weather_proxy_1_802857fd3/keys/time_1412711031' -H "Accept: multipart/mixed"





# curl -XPOST http://blackbird.datamol.net:8098/mapred \
#   -H 'Content-Type: application/json'   \
#   -d '{"inputs":"weather_proxy_1_802857fd3","query":[{"map":{"language":"javascript","name":"Riak.mapValues"}}]}'









