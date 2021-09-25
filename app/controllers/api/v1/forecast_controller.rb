class Api::V1::ForecastController < ApplicationController
  def index
    location = LocationFacade.get_coordinates(params[:location])
    return render_json_error(location) if location.is_a? ErrorSerializer

    forecast = ForecastFacade.get_forecast(lat: location.latitude,
                                           lon: location.longitude)

    render jsonapi: forecast, status: :ok
  end

  private

  def render_json_error(object)
    render json: object.to_hash, status: object.status
  end
end
