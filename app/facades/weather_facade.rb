class WeatherFacade
  class << self

    def get_weather(location)
      Weather.new(WeatherService.get_forecast(location))
    end

    def get_forecast_at(location, time)
      Forecast.new(WeatherService.get_forecast(location), time)
    end

    def get_nil_forecast
      Forecast.new(nil,nil)
    end
  end
end
