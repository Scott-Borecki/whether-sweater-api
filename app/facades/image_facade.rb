class ImageFacade
  def self.get_background_image(**args)
    data_hash = ImageService.get_background_image(**args)

    Image.new(data_hash)
  end
end
