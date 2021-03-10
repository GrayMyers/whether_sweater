class Weather
  attr_reader :current_weather, :daily_weather, :hourly_weather

  DAILY_COUNT = 5
  HOURLY_COUNT = 8

  def initialize(data)
    #datetime, sunrise, sunset, temp, feels_like, humidity, uvi, visibility, conditions, icon
    @current_weather = process_current data[:current]

    #date, sunrise, sunset, max_temp, min_temp, conditions, icon
    @daily_weather = process_daily data[:daily]

    #time, temp, conditions, icon
    @hourly_weather = process_hourly data[:hourly]

  end

  private

  def process_current(current_data)
    #except could be used, but is less explicit and would require some ugly hard coding.
    {
      datetime: Time.at(current_data[:dt]).to_datetime.to_s,
      sunrise: Time.at(current_data[:sunrise]).to_s,
      sunset: Time.at(current_data[:sunset]).to_s,
      temperature: Temperature.new(current_data[:temp]).fahrenheit,
      feels_like: Temperature.new(current_data[:feels_like]).fahrenheit,
      humidity: current_data[:humidity],
      uvi: current_data[:uvi],
      visibility: current_data[:visibility],
      conditions: current_data[:weather][0][:description],
      icon: current_data[:weather][0][:icon]
    }
  end

  def process_daily(daily_data)
    daily_data.map do |data|
      {
        date: Time.at(data[:dt]).to_date.to_s,
        sunrise: Time.at(data[:sunrise]).to_s,
        sunset: Time.at(data[:sunset]).to_s,
        min_temp: Temperature.new(data[:temp][:min]).fahrenheit,
        max_temp: Temperature.new(data[:temp][:max]).fahrenheit,
        conditions: data[:weather][0][:description],
        icon: data[:weather][0][:icon]
      }
    end[0..DAILY_COUNT - 1]
  end

  def process_hourly(hourly_data)
    hourly_data.map do |data|
      {
        time: Time.at(data[:dt]).to_s,
        temperature: Temperature.new(data[:temp]).fahrenheit,
        conditions: data[:weather][0][:description],
        icon: data[:weather][0][:icon]
      }
    end[0..HOURLY_COUNT - 1]
  end
end
