class ImageService
  def self.conn
    Faraday.new(
      url: 'https://api.unsplash.com',
      params: { client_id: ENV['unsplash_api_key'] },
      headers: {
        'Content-Type' => 'application/json',
        'Accept-Version' => 'v1'
      }
    )
  end

  def self.get_background_image(orientation: 'landscape', **args)
    response = conn.get('/photos/random') do |req|
      req.params['query'] = args[:location]
      return unless orientation.present?

      req.params['orientation'] = orientation
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
