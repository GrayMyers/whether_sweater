class Munchie
  attr_reader :destination_city, :travel_time, :hourly, :forecast, :restaurant
  def initialize(restaurant,forecast,travel_time)
    @destination_city = restaurant.city_state
    @travel_time = travel_time.formatted_time
    hourly = forecast.hourly_weather[travel_time.travel_time/3600]
    @forecast = {
      summary: hourly[:conditions],
      temperature: kelvin_to_fahrenheit(hourly[:temperature]).floor.to_s
    }
    @restaurant = {
      name: restaurant.name,
      address: restaurant.address
    }
  end

  private

  def kelvin_to_fahrenheit(temp)
    (temp - 273.15) * 9/5 + 32
  end
end
