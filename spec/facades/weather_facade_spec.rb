require "rails_helper"

describe "weather facade" do
  describe "get_weather" do
    describe "(happy path)" do
      it "returns valid weather when given appropriate params" do
        place = "denver,co"

        json_response = File.read("spec/fixtures/get_forecast_spec/geocode.json")
        stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{place}")
          .to_return(status: 200, body: json_response)

        @coords = GeocodeFacade.get_position(place)

        json_response = File.read("spec/fixtures/get_forecast_spec/forecast.json")
        stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV["OPENWEATHER_KEY"]}&lat=#{@coords.lat}&lon=#{@coords.lon}")
          .to_return(status: 200, body: json_response)

        weather = WeatherFacade.get_weather(@coords)

        expect(weather).to be_a Weather
      end
    end

    describe "(sad path)" do

    end
  end

  describe "get_forecast_at" do
    describe "(happy path)" do
      it "returns a valid forecast when given proper data" do
        place = "denver,co"
        time = 40

        json_response = File.read("spec/fixtures/get_forecast_spec/geocode.json")
        stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{place}")
          .to_return(status: 200, body: json_response)

        @coords = GeocodeFacade.get_position(place)

        json_response = File.read("spec/fixtures/get_forecast_spec/forecast.json")
        stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV["OPENWEATHER_KEY"]}&lat=#{@coords.lat}&lon=#{@coords.lon}")
          .to_return(status: 200, body: json_response)

        weather = WeatherFacade.get_forecast_at(@coords, time)

        expect(weather).to be_a Forecast
      end
    end

    describe "(sad path)" do

    end
  end
end
