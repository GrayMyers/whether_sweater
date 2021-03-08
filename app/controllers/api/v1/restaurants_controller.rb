class Api::V1::RestaurantsController < ApplicationController
  def munchies
    travel_time = GeocodeFacade.get_travel_time(params[:start],params[:destination])



    restaurant = RestaurantSearchFacade.get_restaurant(params[:destination], params[:food], travel_time)
    coords = GeocodeFacade.get_position(params[:start])
    weather = WeatherFacade.get_weather(coords)

    munchie = Munchie.new(restaurant,weather,travel_time)

    render json: MunchieSerializer.new(munchie)
  end
end
