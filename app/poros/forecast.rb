class Forecast
  attr_reader :id, :current_weather, :daily_weather, :hourly_weather

  def initialize(data)
    @id              = nil
    @current_weather = populate_current_weather(data)
    @daily_weather   = populate_daily_weather(data)
    @hourly_weather  = populate_hourly_weather(data)
  end

  def populate_current_weather(data)
    {
      datetime:    Time.zone.at(data[:current][:dt]).to_s,
      sunrise:     Time.zone.at(data[:current][:sunrise]).to_s,
      sunset:      Time.zone.at(data[:current][:sunset]).to_s,
      temperature: data[:current][:temp],
      feels_like:  data[:current][:feels_like],
      humidity:    data[:current][:humidity],
      uvi:         data[:current][:uvi],
      visibility:  data[:current][:visibility],
      conditions:  data[:current][:weather].first[:description],
      icon:        data[:current][:weather].first[:icon]
    }
  end

  def populate_daily_weather(data)
    data[:daily].map do |day|
      {
        date:       Time.zone.at(day[:dt]).strftime('%Y-%m-%d'),
        sunrise:    Time.zone.at(day[:sunrise]).to_s,
        sunset:     Time.zone.at(day[:sunset]).to_s,
        max_temp:   day[:temp][:max],
        min_temp:   day[:temp][:min],
        conditions: day[:weather].first[:description],
        icon:       day[:weather].first[:icon]
      }
    end
  end

  def populate_hourly_weather(data)
    data[:hourly].map do |hour|
      {
        time:        Time.zone.at(hour[:dt]).to_s(:time),
        temperature: hour[:temp],
        conditions:  hour[:weather].first[:description],
        icon:        hour[:weather].first[:icon]
      }
    end
  end

  def weather_at_eta(travel_time_seconds)
    hour_index = travel_time_seconds / 3600

    {
      conditions: hourly_weather[hour_index][:conditions],
      temperature: hourly_weather[hour_index][:temperature]
    }
  end
end
