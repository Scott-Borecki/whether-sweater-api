class Api::V1::ForecastController < ApplicationController
  before_action :validate_location, only: [:index]

  def index
    forecast = ForecastFacade.get_forecast(params[:location])

    render jsonapi: forecast, status: :ok
  end

  private

  def validate_location
    validator = LocationValidator.new(location: params[:location])
    return if validator.valid?

    render json_error_response(validator.errors, :bad_request)
  end
end
