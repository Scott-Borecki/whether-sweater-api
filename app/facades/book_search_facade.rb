class BookSearchFacade
  def self.get_books_based_on_location(args)
    books = LibraryService.get_books_based_on_location(args)
    coordinates = MapFacade.get_coordinates(args[:location])
    forecast = WeatherService.get_forecast(lat: coordinates.latitude,
                                           lon: coordinates.longitude)

    BookCollection.new(books, forecast)
  end
end
