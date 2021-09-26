class Image
  attr_reader :image

  def initialize(data)
    @image = populate_image(data)
  end

  def id
    nil
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
