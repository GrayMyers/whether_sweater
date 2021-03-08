require "rails_helper"
require "./spec/fixtures/weather_poro_spec/data.rb" #this is an enormous file which was hard coded to prevent an over-complicated test
describe Weather do
  it "exists and has attributes" do
    weather = Weather.new(DATA) #DATA comes from the above mentioned enormous file
    current = { #these pieces of data come from hard coded hashes in the specified format using the sample DATA
      :datetime=>"2021-03-07T20:08:24-07:00",
      :sunrise=>"2021-03-07 06:19:40 -0700",
      :sunset=>"2021-03-07 17:54:28 -0700",
      :temperature=>282.77,
      :feels_like=>279.95,
      :humidity=>38,
      :uvi=>0,
      :visibility=>10000,
      :conditions=>"broken clouds",
      :icon=>"04n"
    }

     daily = [
      {:date=>"2021-03-07", :sunrise=>"2021-03-07 06:19:40 -0700", :sunset=>"2021-03-07 17:54:28 -0700", :min_temp=>278.46, :max_temp=>290.85, :conditions=>"overcast clouds", :icon=>"04d"},
      {:date=>"2021-03-08", :sunrise=>"2021-03-08 06:18:07 -0700", :sunset=>"2021-03-08 17:55:31 -0700", :min_temp=>280.32, :max_temp=>291.27, :conditions=>"overcast clouds", :icon=>"04d"},
      {:date=>"2021-03-09", :sunrise=>"2021-03-09 06:16:33 -0700", :sunset=>"2021-03-09 17:56:34 -0700", :min_temp=>280.34, :max_temp=>291.04, :conditions=>"scattered clouds", :icon=>"03d"},
      {:date=>"2021-03-10", :sunrise=>"2021-03-10 06:14:58 -0700", :sunset=>"2021-03-10 17:57:36 -0700", :min_temp=>275.04, :max_temp=>283.96, :conditions=>"clear sky", :icon=>"01d"},
      {:date=>"2021-03-11", :sunrise=>"2021-03-11 06:13:23 -0700", :sunset=>"2021-03-11 17:58:38 -0700", :min_temp=>273.42, :max_temp=>279.41, :conditions=>"overcast clouds", :icon=>"04d"}
    ]

    hourly = [
      {:time=>"2021-03-07 20:00:00 -0700", :temperature=>282.77, :conditions=>"broken clouds", :icon=>"04n"},
      {:time=>"2021-03-07 21:00:00 -0700", :temperature=>282.96, :conditions=>"broken clouds", :icon=>"04n"},
      {:time=>"2021-03-07 22:00:00 -0700", :temperature=>282.47, :conditions=>"broken clouds", :icon=>"04n"},
      {:time=>"2021-03-07 23:00:00 -0700", :temperature=>281.89, :conditions=>"broken clouds", :icon=>"04n"},
      {:time=>"2021-03-08 00:00:00 -0700", :temperature=>281.58, :conditions=>"overcast clouds", :icon=>"04n"},
      {:time=>"2021-03-08 01:00:00 -0700", :temperature=>281.65, :conditions=>"overcast clouds", :icon=>"04n"},
      {:time=>"2021-03-08 02:00:00 -0700", :temperature=>281.34, :conditions=>"overcast clouds", :icon=>"04n"},
      {:time=>"2021-03-08 03:00:00 -0700", :temperature=>281.13, :conditions=>"overcast clouds", :icon=>"04n"}
    ]

    expect(weather.current_weather).to eq(current) #these tests ensure that no extra data is being sent.
    expect(weather.daily_weather).to eq(daily)
    expect(weather.hourly_weather).to eq(hourly)
  end
end
