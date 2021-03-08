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
  end
end
