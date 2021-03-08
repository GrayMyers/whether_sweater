class GeocodeFacade
  class << self

    def get_position(location)
      Location.new(GeocodeService.get_coords(location))
    end

    def get_travel_time(start,destination)
      TravelTime.new(GeocodeService.get_travel_time(start,destination))
    end
  end
end
