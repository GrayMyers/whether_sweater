class RoadtripSerializer
  include FastJsonapi::ObjectSerializer
  set_id {nil}
  attributes :start_city, :end_city, :travel_time

  attribute :weather_at_eta do |road_trip_info,params|
    {
      temperature: road_trip_info.forecast.temperature,
      conditions: road_trip_info.forecast.conditions
    }
  end
end
