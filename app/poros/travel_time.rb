class TravelTime
  attr_reader :arrival_time, :formatted_time, :travel_time

  def initialize(travel_time)
    @travel_time = travel_time
    @arrival_time = Time.now.to_i + travel_time
    @formatted_time = Time.at(travel_time).utc.strftime("%k hours %M min")
  end
end
