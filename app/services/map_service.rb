class MapService
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

  def self.get_directions(args)
    response = conn.get('/directions/v2/route') do |req|
      req.params['from'] = args[:origin]
      req.params['to']   = args[:destination]
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
