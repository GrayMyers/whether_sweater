class WeatherFacade
  class << self

    def get_weather(location)
      Weather.new(WeatherService.get_forecast(location))
    end
  end
end
