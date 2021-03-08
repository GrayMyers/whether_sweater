require "rails_helper"

describe 'Get restaurant request' do
  describe '(happy path)' do
    it "returns formatted data" do
      place = "pueblo,co"
      start_place = "denver,co"
      food = "burger"

      json_response = File.read("spec/fixtures/get_restaurant_spec/mapquest_directions.json")
      stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?key=#{ENV["MAPQUEST_KEY"]}&from=#{start_place}&to=#{place}")
        .to_return(status: 200, body: json_response)

      arrival_time = GeocodeService.get_travel_time(start_place,place)
      #https://api.yelp.com/v3/businesses/search?location=pueblo,co&open_at=12031929310293?term=burger
      json_response = File.read("spec/fixtures/get_restaurant_spec/yelp_search.json")
      stub_request(:get, "https://api.yelp.com/v3/businesses/search?location=pueblo,co&open_at=12031929310293&term=burger")
        .with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>"Bearer #{ENV["YELP_KEY"]}",
          'User-Agent'=>'Faraday v1.3.0'
           })
        .to_return(status: 200, body: json_response)

      json_response = File.read("spec/fixtures/get_forecast_spec/geocode.json")
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{place}")
        .to_return(status: 200, body: json_response)

      json_response = File.read("spec/fixtures/get_forecast_spec/geocode.json")
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{start_place}")
        .to_return(status: 200, body: json_response)

      coords = GeocodeFacade.get_position(place)

      json_response = File.read("spec/fixtures/get_forecast_spec/forecast.json")
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV["OPENWEATHER_KEY"]}&lat=#{coords.lat}&lon=#{coords.lon}")
        .to_return(status: 200, body: json_response)

      get "/api/v1/munchies?start=#{start_place}&destination=#{place}&food=#{food}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data]).to be_a Hash
      expect(parsed[:data][:id]).to eq(nil)
      expect(parsed[:data][:type]).to eq("munchie")

      expect(parsed[:data][:attributes]).to be_a Hash
      expect(parsed[:data][:attributes][:destination_city]).to eq("Pueblo, CO")
      expect(parsed[:data][:attributes][:travel_time]).to eq("1 hours 44 min")

      expect(parsed[:data][:attributes][:forecast]).to be_a Hash
      expect(parsed[:data][:attributes][:forecast][:summary]).to be_a String
      expect(parsed[:data][:attributes][:forecast][:temperature]).to be_a String

      expect(parsed[:data][:attributes][:restaurant]).to be_a Hash
      expect(parsed[:data][:attributes][:restaurant][:name]).to eq("Burgers-R-Us")
      expect(parsed[:data][:attributes][:restaurant][:address]).to eq("4602 N. Elizabeth St, Ste 120, Pueblo, CO 81008")
    end
  end
end
