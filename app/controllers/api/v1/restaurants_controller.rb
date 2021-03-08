class Api::V1::RestaurantsController < ApplicationController
  def munchies
    mapquest_conn = Faraday.new("http://www.mapquestapi.com")
    directions = mapquest_conn.get("/directions/v2/route") do |req|
      req.params[:key]=ENV["MAPQUEST_KEY"]
      req.params[:from]=params[:start]
      req.params[:to]=params[:destination]
    end
    parsed_directions = parse(directions)
    travel_time = parsed_directions[:route][:time]
    formatted_time = Time.at(travel_time).utc.strftime("%k hours %M minutes")
    arrival_time = Time.now.to_i + travel_time

    yelp_conn = Faraday.new("https://api.yelp.com")
    search = yelp_conn.get("/v3/businesses/search") do |req|
      req.params[:open_at] = 12031929310293# arrival_time
      req.params[:term] = params[:food]
      req.params[:location] = params[:destination]
      req.headers[:Authorization] = "Bearer #{ENV["YELP_KEY"]}"
    end
    parsed_search = parse(search)
    city_state = parsed_search[:businesses][0][:location][:city] + ", " + parsed_search[:businesses][0][:location][:state]

    name = parsed_search[:businesses][0][:name]
    address = parsed_search[:businesses][0][:location][:display_address] * ", "

    coords = GeocodeFacade.get_position(params[:start])
    weather = WeatherFacade.get_weather(coords)
  end

  private

  def parse(thing)
    JSON.parse(thing.body, symbolize_names: true)
  end
end
