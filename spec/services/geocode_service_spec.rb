require "rails_helper"

describe GeocodeService do
  it "get_coords" do
    @place = "denver,co"

    json_response = File.read("spec/fixtures/get_forecast_spec/geocode.json")
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{@place}")
      .to_return(status: 200, body: json_response)

    pos = GeocodeService.get_coords(@place)

    expect(pos).to be_a Hash
    expect(pos[:lat]).to be_a Numeric
    expect(pos[:lng]).to be_a Numeric
  end

  it "get_travel_time" do
    start_place = "denver,co"
    place = "pueblo,co"

    json_response = File.read("spec/fixtures/get_restaurant_spec/mapquest_directions.json")
    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?key=#{ENV["MAPQUEST_KEY"]}&from=#{start_place}&to=#{place}")
      .to_return(status: 200, body: json_response)

    travel_time = GeocodeService.get_travel_time(start_place, place)
    expect(travel_time).to eq(6262)
  end
end
