module RequestSpecHelper
  # Parse JSON response to ruby hash with symbolized names
  def json
    JSON.parse(response.body, symbolize_names: true)
  end
end
