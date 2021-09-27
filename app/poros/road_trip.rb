class RoadTrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(directions, forecast)
    @start_city     = origin
    @end_city       = destination
    @travel_time    = travel_time_formatted
    @weather_at_eta = populate_weather(data[:xxx])
  end

  def origin
    city = directions[:route][:locations].first[:adminArea5]
    state = directions[:route][:locations].first[:adminArea3]
    "#{city}, #{state}"
  end

  def destination
    city = directions[:route][:locations].last[:adminArea5]
    state = directions[:route][:locations].last[:adminArea3]
    "#{city}, #{state}"
  end

  # Returns the estimated route time over the route path using current traffic
  # conditions and speeds (where available) along with historical traffic
  # conditions.  This estimate is most useful on short routes where current
  # conditions produce a higher percentage impact to the total route time.
  def estimated_travel_time
    total_seconds = directions[:route][:realTime]
    hours = total_seconds / 3600
    minutes = total_seconds % 3600

    if hours.zero?
      "#{minutes} minutes"
    else
      "#{hours} hours, #{minutes} minutes"
    end
  end

  # Returns the calculated elapsed time for the route, without consideration
  # for current traffic conditions, current traffic speeds, or historical
  # traffic conditions.
  def calculated_travel_time
    total_seconds = directions[:route][:time]
    hours = total_seconds / 3600
    minutes = total_seconds % 3600

    if hours.zero?
      "#{minutes} minutes"
    else
      "#{hours} hours, #{minutes} minutes"
    end
  end
end
