class WeatherService
  def self.conn
    Faraday.new(
      url: 'https://api.openweathermap.org',
      params: { appid: ENV['open_weather_api_key'] },
      headers: { 'Content-Type' => 'application/json' }
    )
  end

  # :exclude options: 'current,minutely,hourly,daily,alerts'
  # :units options:   'standard,metric,imperial'
  def self.get_forecast(exclude: 'minutely,alerts', units: 'imperial',
                        **arguments)
    response = conn.get('/data/2.5/onecall') do |req|
      req.params['lat']     = arguments[:lat]
      req.params['lon']     = arguments[:lon]
      req.params['exclude'] = arguments[:exclude] || exclude
      req.params['units']   = arguments[:units] || units
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
