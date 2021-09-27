class RoadTripFacade
  def self.get_road_trip(args)
    directions = MapFacade.get_directions(args)
    forecast = WeatherFacade.get_forecast(lat: directions.end_latitude,
                                          lon: directions.end_longitude)

    RoadTrip.new(directions, forecast)
  end
end
