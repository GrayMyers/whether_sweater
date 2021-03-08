require "rails_helper"

describe "geocode facade" do
  it "get_position" do
    @place = "denver,co"

    place = "denver,co"

    json_response = File.read("spec/fixtures/get_forecast_spec/geocode.json")
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{@place}")
      .to_return(status: 200, body: json_response)

    @coords = GeocodeFacade.get_position(place)

    json_response = File.read("spec/fixtures/get_forecast_spec/forecast.json")
    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV["OPENWEATHER_KEY"]}&lat=#{@coords.lat}&lon=#{@coords.lon}")
      .to_return(status: 200, body: json_response)

    weather = WeatherFacade.get_weather(@coords)

    expect(weather).to be_a Weather

    expect(weather.current_weather).to be_a Hash
    expect(weather.current_weather[:datetime]).to be_a String

    expect(weather.daily_weather).to be_a Array
    expect(weather.daily_weather[0][:date]).to be_a String

    expect(weather.hourly_weather).to be_a Array
    expect(weather.hourly_weather[0][:time]).to be_a String


  end
end
