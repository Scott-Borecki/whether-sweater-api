class WeatherFacade
  def self.get_forecast(**arguments)
    data_hash = WeatherService.get_forecast(**arguments)

    if data_hash[:message].present?
      ErrorSerializer.new(messages: [data_hash[:message]],
                          status: data_hash[:cod])
    else
      Forecast.new(data_hash)
    end
  end
end
