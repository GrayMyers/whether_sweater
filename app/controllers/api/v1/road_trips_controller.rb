class Api::V1::RoadTripsController < ApplicationController
  before_action :authenticate_user

  def create
    body = json_body
    token = json_body[:api_key]
    user_id = validate_token(token)
    road_trip = RoadTrip.new(start: body[:origin], destination: body[:destination], user_id: user_id)
    if road_trip.save
      render_successful_road_trip(road_trip)
    else
      render_error(road_trip.errors.full_messages.uniq, 400)
    end
  end

  private

  def authenticate_user
    body = json_body
    token = json_body[:api_key]
    if !validate_token(token)
      render_error(["invalid authentication"], 401)
    end
  end

  def render_successful_road_trip(road_trip)
    road_trip_info = RoadTripFacade.get_info(road_trip)
    render json: RoadtripSerializer.new(road_trip_info), status: 201
  end
end
