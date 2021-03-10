require "rails_helper"

describe Forecast do
  require "./spec/fixtures/weather_poro_spec/data.rb" #this is an enormous file which was hard coded to prevent an over-complicated test


  it "exists and has attributes" do
    hours = 40
    weather = Forecast.new(DATA,40) #DATA comes from the fixture file
    expect(weather).to be_a Forecast
    expect(weather.temperature).to eq(62.20400000000005)
    expect(weather.conditions).to eq("scattered clouds")
  end

end
