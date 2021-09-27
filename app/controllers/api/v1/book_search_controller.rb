class Api::V1::BookSearchController < ApplicationController
  before_action :validate_location, only: [:index]
  before_action :validate_quantity, only: [:index]

  def index
    books = LibraryService.get_books_based_on_location(book_search_params)
    coordinates = MapFacade.get_coordinates(params[:location])
    forecast = WeatherService.get_forecast(lat: coordinates.latitude,
                                           lon: coordinates.longitude)

    book_collection = BookCollection.new(books, forecast)

    render jsonapi: book_collection, status: :ok
  end

  private

  def validate_location
    validator = LocationValidator.new(location: params[:location])
    return if validator.valid?

    render json_error_response(validator.errors, :bad_request)
  end

  def validate_quantity
    validator = QuantityValidator.new(quantity: params[:quantity])
    return if validator.valid?

    render json_error_response(validator.errors, :bad_request)
  end

  def book_search_params
    { location: params[:location], quantity: params[:quantity] }
  end
end
