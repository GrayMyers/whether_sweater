class ImageFacade
  class << self
    def get_image(location)
      Image.new(ImageService.get_bg_image(location))
    end
  end
end
