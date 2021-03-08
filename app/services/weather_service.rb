class WeatherService < ApplicationService
  class << self

    def conn
      @conn ||= Faraday.new("https://api.openweathermap.org")
    end

    def get_forecast(location)
      openweather_key = ENV["OPENWEATHER_KEY"]

      response = conn.get("/data/2.5/onecall") do |req|
        req.params['appid'] = openweather_key
        req.params['lat'] = location.lat
        req.params['lon'] = location.lon
      end
      json_parse(response)
    end
  end
end
