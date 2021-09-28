class RoadTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(directions, forecast = nil)
    @id = nil

    if forecast.nil?
      @start_city     = directions[:origin].sub(',', ', ')
      @end_city       = directions[:destination].sub(',', ', ')
      @travel_time    = 'impossible'
      @weather_at_eta = {}
    else
      @start_city     = directions.start_city
      @end_city       = directions.end_city
      @travel_time    = directions.travel_time
      @weather_at_eta = forecast.weather_at_eta(directions.travel_time_seconds)
    end
  end
end
