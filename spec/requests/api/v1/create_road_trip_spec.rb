require "rails_helper"
describe "User login", type: :request do
  describe "(happy path)" do
    it "creates and renders a valid road trip when credentials are given" do

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

      payload = {
        origin: start,
        destination: destination,
        api_key: token
      }

      post "/api/v1/road_trip", params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(201)

      data = JSON.parse(response.body, symbolize_names: true)[:data]
      attributes = data[:attributes]

      expected = {
        :start_city=>"denver",
        :end_city=>"pueblo",
        :travel_time=>"1 hours 44 min",
        :weather_at_eta=>{
          :temperature=>49.658,
          :conditions=>"broken clouds"
          }
        }

      expect(data[:id]).to eq(nil)
      expect(data[:type]).to eq("roadtrip")
      expect(data[:attributes]).to eq(expected) #this tests that unnecessary values are excluded

    end
  end

  describe "(sad path)" do
    it "returns a 401 error if invalid or missing token" do
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

      payload = {
        origin: start,
        destination: destination,
        api_key: "b"
      }

      post "/api/v1/road_trip", params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

      expect(response.status).to eq(401)

      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:errors]).to eq(["invalid authentication"])
    end

    it "returns a partially empty road trip if no path exists" do
      email = "me@example.com"
      password = "IWillNeverGetHacked123"
      start = "denver"
      destination = "london"

      json_response = File.read("spec/fixtures/road_trip_spec/pueblo_coords.json")
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&location=#{destination}")
         .to_return(status: 200, body: json_response)

      coords = GeocodeFacade.get_position(destination)

      json_response = File.read("spec/fixtures/get_forecast_spec/forecast.json")
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV["OPENWEATHER_KEY"]}&lat=#{coords.lat}&lon=#{coords.lon}")
        .to_return(status: 200, body: json_response)

      json_response = File.read("spec/fixtures/road_trip_spec/invalid_directions.json")
      stub_request(:get, "http://www.mapquestapi.com/directions/v2/route?from=#{start}&key=#{ENV["MAPQUEST_KEY"]}&to=#{destination}")
        .to_return(status: 200, body: json_response)

      user = User.create(email: email, password: password, password_confirmation: password)
      token = JsonWebToken.encode(user_id: user.id)

      payload = {
        origin: start,
        destination: destination,
        api_key: token
      }

      post "/api/v1/road_trip", params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

      expect(response.status).to eq(201)

      parsed = JSON.parse(response.body, symbolize_names: true)
      data = parsed[:data]

      expected = {
        :start_city=>"denver",
        :end_city=>"london",
        :travel_time=>"impossible",
        :weather_at_eta=>{
          :temperature=>nil,
          :conditions=>nil
          }
        }

      expect(data[:id]).to eq(nil)
      expect(data[:type]).to eq("roadtrip")
      expect(data[:attributes]).to eq(expected) #this tests that unnecessary values are excluded
    end

    it "returns a 400 error if invalid road trip info" do
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

      payload = {
        origin: start,
        destination: "",
        api_key: token
      }

      post "/api/v1/road_trip", params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

      expect(response.status).to eq(400)

      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed[:errors]).to eq(["Destination can't be blank"])
    end
  end

end
