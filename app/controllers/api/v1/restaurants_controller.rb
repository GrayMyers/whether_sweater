class Api::V1::RestaurantsController < ApplicationController
  def munchies
    travel_time = GeocodeService.get_travel_time(params[:start],params[:destination])


    

    coords = GeocodeFacade.get_position(params[:start])
    weather = WeatherFacade.get_weather(coords)
  end

  private

  def parse(thing)
    JSON.parse(thing.body, symbolize_names: true)
  end
end
