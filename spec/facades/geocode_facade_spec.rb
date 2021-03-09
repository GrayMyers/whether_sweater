require "rails_helper"

describe "geocode facade" do
  it "get_weather" do
    @place = "denver,co"

    place = "denver,co"

    json_response = File.read("spec/fixtures/get_forecast_spec/geocode.json")
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{@place}")
      .to_return(status: 200, body: json_response)

    @coords = GeocodeFacade.get_position(place)

    json_response = File.read("spec/fixtures/get_forecast_spec/forecast.json")
    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV["OPENWEATHER_KEY"]}&lat=#{@coords.lat}&lon=#{@coords.lon}")
      .to_return(status: 200, body: json_response)

    expect(@coords).to be_a Location
  end
end
