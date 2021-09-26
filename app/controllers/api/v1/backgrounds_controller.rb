class Api::V1::BackgroundsController < ApplicationController
  before_action :validate_location, only: [:index]

  def index
    bg_image = ImageFacade.get_background_image(location: params[:location])

    render jsonapi: bg_image, status: :ok
  end

  private

  def validate_location
    validator = LocationValidator.new(location: params[:location])
    return if validator.valid?

    render json_error_response(validator.errors, :bad_request)
  end
end
