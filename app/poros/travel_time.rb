class TravelTime
  attr_reader :arrival_time, :formatted_time, :travel_time, :hours

  SECONDS_PER_HOUR = 3600
  SECONDS_PER_MINUTE = 60
  MINUTES_PER_HOUR = 60

  def initialize(travel_time)
    if travel_time != 0 #returns 0 if trip is not possible
      @hours = travel_time/SECONDS_PER_HOUR
      @travel_time = travel_time
      @arrival_time = Time.now.to_i + travel_time
      @formatted_time = format_time(travel_time)
    else
      @hours = nil
      @travel_time = nil
      @arrival_time = nil
      @formatted_time = "impossible"
    end
  end

  private

  def format_time(travel_time)
    hours = travel_time/SECONDS_PER_HOUR
    minutes = (travel_time/SECONDS_PER_MINUTE)%MINUTES_PER_HOUR
    "#{hours} hours #{minutes} min" #has to be calculated manually due to trips taking multiple days.
  end
end
