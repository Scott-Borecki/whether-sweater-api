class ForecastFacade
  def self.get_forecast(location)
    coordinates = MapFacade.get_coordinates(location)
    return coordinates if coordinates.is_a? ErrorSerializer

    WeatherFacade.get_forecast(lat: coordinates.latitude,
                               lon: coordinates.longitude)
  end
end
