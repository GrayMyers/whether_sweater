class RoadTripFacade
  class << self
    def get_info(road_trip)
      start = road_trip.start
      destination = road_trip.destination
      dest_location = GeocodeFacade.get_position(destination)
      travel_time = GeocodeFacade.get_travel_time(start,destination)
      if travel_time.travel_time
        forecast = WeatherFacade.get_forecast_at(dest_location, travel_time.hours)
      else
        forecast = WeatherFacade.get_nil_forecast
      end

      RoadTripInfo.new(road_trip, travel_time, forecast)
    end
  end
end
