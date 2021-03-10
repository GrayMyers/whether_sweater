class Forecast
  attr_reader :temperature, :conditions

  def initialize(data, time)
    @temperature = Temperature.new(data[:hourly][time][:temp]).fahrenheit
    @conditions = data[:hourly][time][:weather][0][:description]
  end
end
