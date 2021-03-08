class Api::V1::ForecastController < ApplicationController
  def get_forecast
    coords = GeocodeFacade.get_position(params[:location])

    weather = WeatherFacade.get_weather(coords)

    render json: ForecastSerializer.new(weather)
  end
end
