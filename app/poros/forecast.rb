class Forecast
  attr_reader :temperature, :conditions

  def initialize(data, time)
    if data
      @temperature = Temperature.new(data[:hourly][time][:temp]).fahrenheit
      @conditions = data[:hourly][time][:weather][0][:description]
    else
      @temperature = nil
      @conditions = nil
    end
  end
end
