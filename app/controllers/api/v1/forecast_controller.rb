class Api::V1::ForecastController < ApplicationController
  def get_forecast
    if params[:location] and params[:location] != ""
      coords = GeocodeFacade.get_position(params[:location])

      weather = WeatherFacade.get_weather(coords)

      render json: ForecastSerializer.new(weather)
    else
      render json: {error: "invalid location"}, status: 404
    end
  end
end
