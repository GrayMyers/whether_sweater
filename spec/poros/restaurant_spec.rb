require "rails_helper"

describe Restaurant do
  it "exists and has attributes" do
    data = {
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
    restaurant = Restaurant.new(data)

    expect(restaurant).to be_a Restaurant
    expect(restaurant.name).to eq(data[:name])
    expect(restaurant.address).to eq(data[:location][:display_address] * ', ')
    expect(restaurant.city_state).to eq(data[:location][:city] + ", " + data[:location][:state])

  end
end
