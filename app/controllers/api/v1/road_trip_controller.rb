class Api::V1::RoadTripController < ApplicationController
  before_action :validate_api_key, only: [:index]
  before_action :validate_origin, only: [:index]
  before_action :validate_destination, only: [:index]

  def index
    road_trip = RoadTripFacade.get_road_trip(road_trip_params)
    render jsonapi: road_trip, status: :ok
  end

  private

  def road_trip_params
    params.permit(:origin, :destination)
  end

  def validate_api_key
    api_key = ApiKey.find_by(token: params[:api_key])
    return render(invalid_api_key) if api_key.nil?
  end

  def invalid_api_key
    json_error_response(['You have entered an invalid API key'],
                        :forbidden)
  end

  def validate_origin
    validator = LocationValidator.new(location: params[:origin])
    return if validator.valid?

    render json_error_response(validator.errors, :bad_request)
  end

  def validate_destination
    validator = LocationValidator.new(location: params[:destination])
    return if validator.valid?

    render json_error_response(validator.errors, :bad_request)
  end
end
