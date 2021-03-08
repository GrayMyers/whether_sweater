require "rails_helper"

describe TravelTime do
  it "exists and has attributes" do
    t = 6262
    travel_time = TravelTime.new(t)

    expect(travel_time.travel_time).to eq(t)
    expect(travel_time.formatted_time).to eq("1 hours 44 min")
    expect(travel_time.arrival_time).to eq(Time.now.to_i + t)
  end
end
