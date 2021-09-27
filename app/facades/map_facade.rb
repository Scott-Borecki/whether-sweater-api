class MapFacade
  def self.get_coordinates(location)
    data_hash = MapService.get_coordinates(location)

    if data_hash[:info][:messages].present?
      ErrorSerializer.new(messages: data_hash[:info][:messages],
                          status: data_hash[:info][:statuscode])
    else
      Location.new(data_hash)
    end
  end

  def self.get_directions(args)
    data_hash = MapService.get_directions(args)

    Directions.new(data_hash)
  end
end
