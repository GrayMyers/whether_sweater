require "rails_helper"

describe "roadtrip facade" do
  describe "get_info" do
    describe "(happy path)" do
      it "returns valid info" do
        email = "me@example.com"
        password = "IWillNeverGetHacked123"
        start = "denver"
        destination = "pueblo"

        json_response = File.read("spec/fixtures/road_trip_spec/pueblo_coords.json")
        stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{destination}")
           .to_return(status: 200, body: json_response)

        coords = GeocodeFacade.get_position(destination)

        json_response = File.read("spec/fixtures/get_forecast_spec/forecast.json")
        stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV["OPENWEATHER_KEY"]}&lat=#{coords.lat}&lon=#{coords.lon}")
          .to_return(status: 200, body: json_response)

        json_response = File.read("spec/fixtures/road_trip_spec/pueblo_directions.json")
        stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=#{start}&key=#{ENV["MAPQUEST_KEY"]}&to=#{destination}")
          .to_return(status: 200, body: json_response)

        user = User.create(email: email, password: password, password_confirmation: password)
        token = JsonWebToken.encode(user_id: user.id)

        road_trip = RoadTrip.create(start: start, destination: destination, user_id: user.id)

        info = RoadTripFacade.get_info(road_trip)

        expect(info).to be_a RoadTripInfo
      end
    end
  end
end
