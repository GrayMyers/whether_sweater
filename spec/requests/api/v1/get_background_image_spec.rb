require "rails_helper"

describe 'Get background image request', type: :request do
  describe '(happy path)' do
    it "returns data in correct format" do
      location = "denver,co"

      json_response = File.read('./spec/fixtures/get_forecast_spec/geocode.json')
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{location}")
         .to_return(status: 200, body: json_response)

      coords = GeocodeFacade.get_position(location)

      json_response = File.read('./spec/fixtures/get_bg_image_spec/get_nearest_city.json')
      stub_request(:get, "https://api.teleport.org/api/locations/#{coords.lat},#{coords.lon}/")
        .to_return(status: 200, body: json_response)

      json_response = File.read('./spec/fixtures/get_bg_image_spec/get_images.json')
      stub_request(:get, "https://api.teleport.org/api/urban_areas/slug:denver/images/")
        .to_return(status: 200, body: json_response)

      get "/api/v1/backgrounds?location=denver,co"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data][:id]).to eq(nil)
      expect(parsed[:data][:type]).to eq("image")
      expect(parsed[:data][:attributes][:location]).to eq("Denver")
      expect(parsed[:data][:attributes][:image_url]).to eq("https://d13k13wj6adfdf.cloudfront.net/urban_areas/denver_web-9726d88300.jpg")
      expect(parsed[:data][:attributes][:source]).to eq("Flickr")
      expect(parsed[:data][:attributes][:site]).to eq("Source: Teleport (teleport.org)")
      expect(parsed[:data][:attributes][:author]).to eq("Sheila Sund")
    end
  end

  describe "(sad path)" do
    it "returns a 404 when invalid location is provided" do
      location = ""

      json_response = File.read('./spec/fixtures/get_forecast_spec/geocode.json')
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{location}")
         .to_return(status: 200, body: json_response)

      get "/api/v1/backgrounds?location="

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:errors]).to eq(["invalid location"])
    end
  end
end
