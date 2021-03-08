require "rails_helper"
require "./spec/fixtures/weather_poro_spec/data.rb" #this is an enormous file which was copied from a different test due to time constraints

describe Munchie do
  it "exists and has attributes" do
    restaurant_data = {
     :id=>"8wGSggWsopmqoCyd9bY-dw",
     :alias=>"bingo-burger-pueblo-4",
     :name=>"Bingo Burger",
     :image_url=>"https://s3-media3.fl.yelpcdn.com/bphoto/KyMKYZ2W8nyjocqzkrrEog/o.jpg",
     :is_closed=>false,
     :url=>"https://www.yelp.com/biz/bingo-burger-pueblo-4?adjust_creative=KosUOXKDYb8iXf7LCFqzAA&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=KosUOXKDYb8iXf7LCFqzAA",
     :review_count=>406,
     :categories=>[{:alias=>"burgers", :title=>"Burgers"}],
     :rating=>4.0,
     :coordinates=>{:latitude=>38.268043, :longitude=>-104.609794},
     :transactions=>["pickup", "delivery"],
     :price=>"$$",
     :location=>{:address1=>"101 Central Plz", :address2=>"", :address3=>"", :city=>"Pueblo", :zip_code=>"81003", :country=>"US", :state=>"CO", :display_address=>["101 Central Plz", "Pueblo, CO 81003"]},
     :phone=>"+17192258363",
     :display_phone=>"(719) 225-8363",
     :distance=>3190.6682549996963
    }
    travel_time_data = 6262

    forecast = Weather.new(DATA) #DATA comes from the above mentioned enormous file
    restaurant = Restaurant.new(restaurant_data)
    travel_time = TravelTime.new(travel_time_data)

    munchie = Munchie.new(restaurant,forecast,travel_time)

    expect(munchie).to be_a Munchie
    expect(munchie.destination_city).to eq(restaurant.city_state)
    expect(munchie.travel_time).to eq(travel_time.formatted_time)
    expect(munchie.restaurant).to eq({name: restaurant.name, address: restaurant.address})
    hourly = forecast.hourly_weather[1]
    expected_forecast = {
      temperature: "49",
      summary: hourly[:conditions]
    }
    expect(munchie.forecast).to eq(expected_forecast)
  end
end
