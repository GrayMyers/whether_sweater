class MunchieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :destination_city, :travel_time, :hourly, :forecast, :restaurant
  set_id {nil}
end
