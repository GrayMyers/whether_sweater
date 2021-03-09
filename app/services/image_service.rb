class ImageService < ApplicationService
  class << self

    def conn
      Faraday.new("https://api.teleport.org")
    end

    def get_bg_image(location)
      images_response = Faraday.get(get_images_link(location)) #this returns a full href so the conn is not used here.
      json_parse(images_response)[:photos][0]
    end

    private

    def get_images_link(location)
      response = conn.get("/api/locations/#{location.lat},#{location.lon}/")
      json_parse(response)[:_embedded][:"location:nearest-urban-areas"][0][:_links][:"location:nearest-urban-area"][:href] + 'images/'
    end
  end
end
