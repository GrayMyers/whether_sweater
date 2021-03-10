class RoadTripInfo
  attr_reader :start_city, :end_city, :travel_time, :forecast
  def initialize(road_trip, travel_time, forecast)
    @start_city = road_trip.start
    @end_city = road_trip.destination
    @travel_time = travel_time.formatted_time
    @forecast = forecast
  end
end
