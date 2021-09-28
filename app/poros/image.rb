class Image
  attr_reader :id, :image

  def initialize(data)
    @id    = nil
    @image = populate_image(data)
  end

  def populate_image(data)
    {
      location: data[:location][:name],
      image_url: data[:urls][:full],
      credit: {
        source: data[:user][:links][:html],
        author: data[:user][:username]
      }
    }
  end
end
