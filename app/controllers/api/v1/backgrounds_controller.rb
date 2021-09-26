class Api::V1::BackgroundsController < ApplicationController
  def index
    bg_image = ImageFacade.get_background_image(location: params[:location])

    render jsonapi: bg_image, status: :ok
  end
  #
  # private
  #
  # def render_json_error(object)
  #   render json: object.to_hash, status: object.status
  # end
end