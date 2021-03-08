require "rails_helper"

describe RestaurantSearchFacade do
  it "get_restaurant" do
    start_place = "denver,co"
    place = "pueblo,co"
    term = "burger"
    categories = ["bars","restaurants"]*","

    json_response = File.read("spec/fixtures/get_restaurant_spec/mapquest_directions.json")
    stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?key=#{ENV["MAPQUEST_KEY"]}&from=#{start_place}&to=#{place}")
      .to_return(status: 200, body: json_response)

    travel_time = GeocodeFacade.get_travel_time(start_place,place)

    #https://api.yelp.com/v3/businesses/search?location=pueblo,co&open_at=12031929310293?term=burger
    json_response = File.read("spec/fixtures/get_restaurant_spec/yelp_search.json")
    stub_request(:get, "https://api.yelp.com/v3/businesses/search?location=pueblo,co&open_at=#{travel_time.arrival_time}&term=#{term}&categories=#{categories}")
      .with(
         headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'=>"Bearer #{ENV["YELP_KEY"]}",
        'User-Agent'=>'Faraday v1.3.0'
         })
      .to_return(status: 200, body: json_response)

    results = RestaurantSearchFacade.get_restaurant(place, term, travel_time)

    expect(results).to be_a Restaurant
    expect(results.name).to eq("Bingo Burger")
    expect(results.city_state).to eq("Pueblo, CO")
    expect(results.address).to eq("101 Central Plz, Pueblo, CO 81003")
  end
end
