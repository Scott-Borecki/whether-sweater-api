class LocationService
  def self.conn
    Faraday.new(
      url: 'http://www.mapquestapi.com',
      params: { key: ENV['mapquest_api_key'] },
      headers: { 'Content-Type' => 'application/json' }
    )
  end

  def self.get_coordinates(location)
    response = conn.get('/geocoding/v1/address') do |req|
      req.params['location'] = location
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
