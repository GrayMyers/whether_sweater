require "rails_helper"

describe 'Get forecast request', type: :request do
  describe '(happy path)' do
    it "contains the expected response" do

      place = "denver,co"


      json_response = File.read("spec/fixtures/get_forecast_spec/geocode.json")
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{place}")
        .to_return(status: 200, body: json_response)

      coords = GeocodeFacade.get_position(place)

      json_response = File.read("spec/fixtures/get_forecast_spec/forecast.json")
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV["OPENWEATHER_KEY"]}&lat=#{coords.lat}&lon=#{coords.lon}")
        .to_return(status: 200, body: json_response)

      get "/api/v1/forecast?location=#{place}"
      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      attributes = parsed[:data][:attributes]

      current = attributes[:current_weather]
      daily = attributes[:daily_weather]
      hourly = attributes[:hourly_weather]

      expect(parsed).to be_a Hash
      expect(parsed[:data][:id]).to eq(nil)
      expect(parsed[:data][:type]).to eq('forecast')

      expect(current).to be_a Hash
      expect(current[:datetime]).to be_a String
      expect(current[:temperature]).to be_a Numeric
      expect(current[:sunrise]).to be_a String
      expect(current[:sunset]).to be_a String
      expect(current[:feels_like]).to be_a Numeric
      expect(current[:humidity]).to be_a Numeric
      expect(current[:uvi]).to be_a Numeric
      expect(current[:visibility]).to be_a Numeric
      expect(current[:conditions]).to be_a String
      expect(current[:icon]).to be_a String

      expect(daily).to be_a Array
      expect(daily.count).to eq(5)
      expect(daily[0]).to be_a Hash
      expect(daily[0][:date]).to be_a String
      expect(daily[0][:sunrise]).to be_a String
      expect(daily[0][:sunset]).to be_a String
      expect(daily[0][:max_temp]).to be_a Float
      expect(daily[0][:min_temp]).to be_a Float
      expect(daily[0][:conditions]).to be_a String
      expect(daily[0][:icon]).to be_a String

      expect(hourly).to be_a Array
      expect(hourly.count).to eq(8)
      expect(hourly[0]).to be_a Hash
      expect(hourly[0][:time]).to be_a String
      expect(hourly[0][:temperature]).to be_a Float
      expect(hourly[0][:conditions]).to be_a String
      expect(hourly[0][:icon]).to be_a String
    end
  end

  describe "(sad path)" do

  end
end
