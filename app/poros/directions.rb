class Directions
  include TimeErrorable

  attr_reader :id, :start_city, :end_city, :end_latitude, :end_longitude,
              :travel_time, :travel_time_seconds

  def initialize(directions)
    @id = nil
    @start_city = origin(directions[:route][:locations].first[:adminArea5],
                         directions[:route][:locations].first[:adminArea3])
    @end_city = destination(directions[:route][:locations].last[:adminArea5],
                            directions[:route][:locations].last[:adminArea3])
    @end_latitude = directions[:route][:locations].last[:displayLatLng][:lat]
    @end_longitude = directions[:route][:locations].last[:displayLatLng][:lng]
    @travel_time = estimated_travel_time(directions[:route][:realTime])
    @travel_time_seconds = directions[:route][:realTime]
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
    raise TimeMustBeIntegerError unless travel_time_seconds.is_a? Integer

    hours = travel_time_seconds / 3600
    minutes = travel_time_seconds / 60 % 60

    if hours.zero?
      "#{minutes} minutes"
    elsif hours == 1
      "#{hours} hour, #{minutes} minutes"
    else
      "#{hours} hours, #{minutes} minutes"
    end
  end

  # Returns the calculated elapsed time for the route, without consideration
  # for current traffic conditions, current traffic speeds, or historical
  # traffic conditions.
  def calculated_travel_time(travel_time_seconds)
    raise TimeMustBeIntegerError unless travel_time_seconds.is_a? Integer

    hours = travel_time_seconds / 3600
    minutes = travel_time_seconds / 60 % 60

    if hours.zero?
      "#{minutes} minutes"
    elsif hours == 1
      "#{hours} hour, #{minutes} minutes"
    else
      "#{hours} hours, #{minutes} minutes"
    end
  end
end
