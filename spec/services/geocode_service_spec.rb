require "rails_helper"

describe GeocodeService do
  describe "get_coords" do
    describe "(happy path)" do
      it "returns valid coords of specified location" do
        @place = "denver,co"

        json_response = File.read("spec/fixtures/get_forecast_spec/geocode.json")
        stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{@place}")
          .to_return(status: 200, body: json_response)

        pos = GeocodeService.get_coords(@place)

        expect(pos).to be_a Hash
        expect(pos[:lat]).to eq(39.738453)
        expect(pos[:lng]).to eq(-104.984853)
      end
    end

    describe "(sad path)" do

    end
  end

  describe "get_travel_time" do
    describe "(happy path)" do
      it "returns a valid travel time with proper locations" do
        start_place = "denver,co"
        place = "pueblo,co"

        json_response = File.read("spec/fixtures/road_trip_spec/mapquest_directions.json")
        stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?key=#{ENV["MAPQUEST_KEY"]}&from=#{start_place}&to=#{place}")
          .to_return(status: 200, body: json_response)

        travel_time = GeocodeService.get_travel_time(start_place, place)
        expect(travel_time).to eq(6262)
      end
    end

    describe "(sad path)" do
      it "returns a nil or zero travel time with proper locations" do
        start_place = "denver"
        place = "london"

        json_response = File.read("spec/fixtures/road_trip_spec/invalid_directions.json")
        stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?key=#{ENV["MAPQUEST_KEY"]}&from=#{start_place}&to=#{place}")
          .to_return(status: 200, body: json_response)

        travel_time = GeocodeService.get_travel_time(start_place, place)
        expect(travel_time.to_i).to eq(0)
      end
    end
  end
end
