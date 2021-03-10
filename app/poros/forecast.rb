class Forecast
  attr_reader :temperature, :conditions

  def initialize(data, time)
    @temperature = data[:hourly][time][:temp]
    @conditions = data[:hourly][time][:weather][0][:description]
  end
end
