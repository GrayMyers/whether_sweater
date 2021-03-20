require "rails_helper"
require "./spec/fixtures/weather_poro_spec/data.rb" #this is an enormous file which was hard coded to prevent an over-complicated test
describe Weather do
  it "exists and has attributes" do
    weather = Weather.new(DATA) #DATA comes from the above mentioned enormous file
    current = { #these are hard coded to ensure that no extra data is being sent
      :datetime=>"2021-03-07T20:08:24-07:00",
      :sunrise=>"2021-03-07 06:19:40 -0700",
      :sunset=>"2021-03-07 17:54:28 -0700",
      :temperature=>49.31600000000001,
      :feels_like=>44.24000000000002,
      :humidity=>38,
      :uvi=>0,
      :visibility=>10000,
      :conditions=>"broken clouds",
      :icon=>"04n"
   }

     daily = [
      {
        :date=>"2021-03-07",
        :sunrise=>"2021-03-07 06:19:40 -0700",
        :sunset=>"2021-03-07 17:54:28 -0700",
        :min_temp=>41.55800000000001,
        :max_temp=>63.860000000000085,
        :conditions=>"overcast clouds",
        :icon=>"04d"
      },
      {
        :date=>"2021-03-08",
        :sunrise=>"2021-03-08 06:18:07 -0700",
        :sunset=>"2021-03-08 17:55:31 -0700",
        :min_temp=>44.90600000000003,
        :max_temp=>64.61600000000001,
        :conditions=>"overcast clouds",
        :icon=>"04d"
      },
      {
         :date=>"2021-03-09",
        :sunrise=>"2021-03-09 06:16:33 -0700",
        :sunset=>"2021-03-09 17:56:34 -0700",
        :min_temp=>44.94199999999999,
        :max_temp=>64.20200000000008,
        :conditions=>"scattered clouds",
        :icon=>"03d"
      },
      {
         :date=>"2021-03-10",
        :sunrise=>"2021-03-10 06:14:58 -0700",
        :sunset=>"2021-03-10 17:57:36 -0700",
        :min_temp=>35.40200000000008,
        :max_temp=>51.458000000000006,
        :conditions=>"clear sky",
        :icon=>"01d"
      },
      {
         :date=>"2021-03-11",
        :sunrise=>"2021-03-11 06:13:23 -0700",
        :sunset=>"2021-03-11 17:58:38 -0700",
        :min_temp=>32.48600000000007,
        :max_temp=>43.268000000000086,
        :conditions=>"overcast clouds",
        :icon=>"04d"
      }
    ]

    hourly = [
     {:time=>"2021-03-07 20:00:00 -0700", :temperature=>49.31600000000001, :conditions=>"broken clouds", :icon=>"04n"},
     {:time=>"2021-03-07 21:00:00 -0700", :temperature=>49.658, :conditions=>"broken clouds", :icon=>"04n"},
     {:time=>"2021-03-07 22:00:00 -0700", :temperature=>48.77600000000009, :conditions=>"broken clouds", :icon=>"04n"},
     {:time=>"2021-03-07 23:00:00 -0700", :temperature=>47.73200000000001, :conditions=>"broken clouds", :icon=>"04n"},
     {:time=>"2021-03-08 00:00:00 -0700", :temperature=>47.174000000000014, :conditions=>"overcast clouds", :icon=>"04n"},
     {:time=>"2021-03-08 01:00:00 -0700", :temperature=>47.3, :conditions=>"overcast clouds", :icon=>"04n"},
     {:time=>"2021-03-08 02:00:00 -0700", :temperature=>46.742, :conditions=>"overcast clouds", :icon=>"04n"},
     {:time=>"2021-03-08 03:00:00 -0700", :temperature=>46.36400000000003, :conditions=>"overcast clouds", :icon=>"04n"}
    ]

    expect(weather.current_weather).to eq(current) #these tests ensure that no extra data is being sent.
    expect(weather.daily_weather).to eq(daily)
    expect(weather.hourly_weather).to eq(hourly)
  end
end
