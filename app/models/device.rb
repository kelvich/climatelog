class String
  def is_json?
    begin
      !!JSON.parse(self)
    rescue
      false
    end
  end
end

class Device < ActiveRecord::Base
  has_many :measurements

  def self.load
    buckets_url = 'http://blackbird.datamol.net:8098/types/counters/buckets?buckets=true'
    buckets = JSON.load(Faraday.get(buckets_url).body)["buckets"]

    buckets.each do |bucket|
      Device.where(mac: bucket.split('_').last).first_or_create
    end
  end

  def load_keys
    host = 'http://blackbird.datamol.net:8098'
    url = "#{host}/types/counters/buckets/weather_proxy_1_#{mac}/keys?keys=true"
    JSON.load(Faraday.get(url).body)["keys"]
  end

  def load_keydata(key)
    host = 'http://blackbird.datamol.net:8098'
    url = "#{host}/types/counters/buckets/weather_proxy_1_#{mac}/keys/#{key}"
    body = Faraday.get(url).body
    # JSON.load(body) if body.is_json?
    if body.is_json?
      JSON.load(body)
    else
      vtag = body.split("\n").second
      url = url + "?vtag=#{vtag}"
      JSON.load(Faraday.get(url).body)
    end
  end

  def sync_data
    keys = load_keys
    old_keys = measurements.pluck(:riak_key)


    (keys-old_keys).sort.each do |key|
      m = measurements.where(riak_key: key).first_or_create
      if !m.temperature
        key_data = load_keydata(key)
        if key_data
          m.temperature = key_data['temperature']
          m.pressure = key_data['pressure']
          m.humidity = key_data['humidity']
          m.measured_at = Time.at(key.split('_').last.to_i)
          m.save
        end
      end
    end
  end


end
