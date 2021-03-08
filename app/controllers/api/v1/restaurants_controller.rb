class Api::V1::RestaurantsController < ApplicationController
  def munchies
    mapquest_conn = "http://www.mapquestapi.com"
    mapquest_conn.get("/directions/v2/route?key=#{ENV["MAPQUEST_KEY"]}&from=#{params[:start]}&to=#{params[:destination]}")
  end
end
