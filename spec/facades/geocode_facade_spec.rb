require "rails_helper"

describe "geocode facade" do
  it "get_position" do
    @place = "denver,co"

    place = "denver,co"

    json_response = File.read("spec/fixtures/get_forecast_spec/geocode.json")
    stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{@place}")
      .to_return(status: 200, body: json_response)

    @coords = GeocodeFacade.get_position(place)

    expect(@coords).to be_a Location
    expect(@coords.lat).to be_a Numeric
    expect(@coords.lon).to be_a Numeric


  end

  it "get_travel_time" do
    start_place = "denver,co"
    place = "pueblo,co"

    json_response = File.read("spec/fixtures/get_restaurant_spec/mapquest_directions.json")
    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?key=#{ENV["MAPQUEST_KEY"]}&from=#{start_place}&to=#{place}")
      .to_return(status: 200, body: json_response)

    travel_time = GeocodeFacade.get_travel_time(start_place, place)

    expect(travel_time).to be_a TravelTime
    expect(travel_time.arrival_time).to eq(Time.now.to_i + travel_time.travel_time)
    expect(travel_time.formatted_time).to eq(" 1 hours 44 min")
  end
end
