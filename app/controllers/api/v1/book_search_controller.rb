class Api::V1::BookSearchController < ApplicationController
  def index
    books = LibraryService.get_books_based_on_location(book_search_params)
    coordinates = MapFacade.get_coordinates(params[:location])
    forecast = WeatherService.get_forecast(lat: coordinates.latitude,
                                           lon: coordinates.longitude)

    book_collection = BookCollection.new(books, forecast)

    render jsonapi: book_collection, status: :ok
  end

  private

  def book_search_params
    { location: params[:location], quantity: params[:quantity] }
  end
end
