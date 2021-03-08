require "rails_helper"

describe 'Get restaurant request' do
  describe '(happy path)' do
    it "returns formatted data" do
      place = "pueblo,co"
      start_place = "denver,co"

      json_response = File.read("spec/fixtures/get_forecast_spec/geocode.json")
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{place}")
        .to_return(status: 200, body: json_response)

      json_response = File.read("spec/fixtures/get_restaurant_spec/yelp_search.json")
      stub_request(:get, "https://api.yelp.com/v3/businesses/search?term=#{food}&location=#{place}")
        .to_return(status: 200, body: json_response)

      json_response = File.read("spec/fixtures/get_restaurant_spec/mapquest_directions.json")
      stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?key=#{ENV["MAPQUEST_KEY"]}&from=#{start_place}&to=#{place}")
        .to_return(status: 200, body: json_response)

      get "/api/v1/munchies?start=#{start_place}&destination=pueblo,co&food=#{food}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data]).to be_a Hash
      expect(parsed[:data][:id]).to eq(nil)
      expect(parsed[:data][:type]).to eq("munchie")

      expect(parsed[:data][:attributes]).to be_a Hash
      expect(parsed[:data][:attributes][:destination_city]).to eq("Pueblo, CO")
      expect(parsed[:data][:attributes][:travel_time]).to eq("1 hours 48 min")

      expect(parsed[:data][:attributes][:forecast]).to be_a Hash
      expect(parsed[:data][:attributes][:forecast][:summary]).to be_a String
      expect(parsed[:data][:attributes][:forecast][:temperature]).to be_a String

      expect(parsed[:data][:attributes][:restaurant]).to be_a Hash
      expect(parsed[:data][:attributes][:restaurant][:name]).to eq("Burgers-R-Us")
      expect(parsed[:data][:attributes][:restaurant][:address]).to eq("4602 N. Elizabeth St, Ste 120, Pueblo, CO 81008")
    end
  end
end
