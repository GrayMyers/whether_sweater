require "rails_helper"

describe GeocodeService do
  describe "get_forecast" do
    describe "(happy path)" do
      it "returns weather data" do
        @place = "denver,co"
        json_response = File.read("spec/fixtures/get_forecast_spec/geocode.json")
        stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{@place}")
          .to_return(status: 200, body: json_response)

        @coords = GeocodeFacade.get_position(@place)

        json_response = File.read("spec/fixtures/get_forecast_spec/forecast.json")
        stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV["OPENWEATHER_KEY"]}&lat=#{@coords.lat}&lon=#{@coords.lon}")
          .to_return(status: 200, body: json_response)

        fc = WeatherService.get_forecast(@coords)

        expect(fc).to be_a Hash

        expect(fc[:current]).to be_a Hash
        expect(fc[:current][:weather][0]).to be_a Hash

        expect(fc[:daily].first).to be_a Hash
        expect(fc[:daily][0][:weather][0]).to be_a Hash

        expect(fc[:hourly].first).to be_a Hash
        expect(fc[:hourly][0][:weather][0]).to be_a Hash
      end
    end
  end
end
