class RoadTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(directions, forecast)
    @id             = nil
    @start_city     = origin(directions[:route][:locations].first[:adminArea5],
                             directions[:route][:locations].first[:adminArea3])
    @end_city       = destination(
                        directions[:route][:locations].last[:adminArea5],
                        directions[:route][:locations].last[:adminArea3]
                      )
    @travel_time    = estimated_travel_time(directions[:route][:realTime])
    @weather_at_eta = populate_weather_forecast(directions[:route][:realTime],
                                                forecast)
  end

  def origin(city, state)
    "#{city}, #{state}"
  end

  def destination(city, state)
    "#{city}, #{state}"
  end

  # Returns the estimated route time over the route path using current traffic
  # conditions and speeds (where available) along with historical traffic
  # conditions.  This estimate is most useful on short routes where current
  # conditions produce a higher percentage impact to the total route time.
  def estimated_travel_time(travel_time_seconds)
    hours = travel_time_seconds / 3600
    minutes = travel_time_seconds / 60 % 60

    if hours.zero?
      "#{minutes} minutes"
    else
      "#{hours} hours, #{minutes} minutes"
    end
  end

  # Returns the calculated elapsed time for the route, without consideration
  # for current traffic conditions, current traffic speeds, or historical
  # traffic conditions.
  def calculated_travel_time(travel_time_seconds)
    hours = travel_time_seconds / 3600
    minutes = travel_time_seconds / 60 % 60

    if hours.zero?
      "#{minutes} minutes"
    else
      "#{hours} hours, #{minutes} minutes"
    end
  end

  def populate_weather_forecast(travel_time_seconds, forecast)
    hour_index = travel_time_seconds / 3600

    {
      conditions: forecast[:hourly][hour_index][:weather].first[:description],
      temperature: forecast[:hourly][hour_index][:temp]
    }
  end
end
