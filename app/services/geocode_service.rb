class GeocodeService < ApplicationService
  class << self

    def conn
      @conn ||= Faraday.new("http://www.mapquestapi.com")
    end

    def get_coords(location)
      mapquest_key = ENV["MAPQUEST_KEY"]

      response = conn.get("/geocoding/v1/address") do |req|
        req.params['key'] = mapquest_key
        req.params['location'] = location
      end
      json_parse(response)[:results][0][:locations][0][:latLng]
    end

    def get_travel_time(start,destination)
      mapquest_key = ENV["MAPQUEST_KEY"]

      directions = conn.get("/directions/v2/route") do |req|
        req.params[:key]=ENV["MAPQUEST_KEY"]
        req.params[:from]= start
        req.params[:to]= destination
      end

      parsed_directions = json_parse(directions)
      parsed_directions[:route][:time].to_i
    end
  end
end
