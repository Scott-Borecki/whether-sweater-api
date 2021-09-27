class RoadTripFacade
  def self.get_road_trip(**args)
    directions_hash = MapService.get_directions(**args)
    forecast_hash = WeatherService.get_forecast(
      lat: direcitons_hash[:route][:locations].last[:displayLatLng][:lat],
      lon: direcitons_hash[:route][:locations].last[:displayLatLng][:lng]
    )

    RoadTrip.new(directions_hash, forecast_hash)
  end
end
