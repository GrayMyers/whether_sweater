class GeocodeFacade
  class << self

    def get_position(location)
      Location.new(GeocodeService.get_coords(location))
    end
  end
end
