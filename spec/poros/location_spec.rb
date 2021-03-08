require "rails_helper"

describe Location do
  it "exists and has attributes" do
    data = {
      lat: 5,
      lng: 7
    }

    loc = Location.new(data)

    expect(loc.lat).to eq(data[:lat])
    expect(loc.lon).to eq(data[:lng])

  end
end
