class LocationFacade
  def self.get_coordinates(location)
    json = LocationService.get_coordinates(location)

    if json[:info][:messages].present?
      ErrorSerializer.new(messages: json[:info][:messages],
                          status: json[:info][:statuscode])
    else
      Location.new(json)
    end
  end
end
