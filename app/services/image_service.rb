class ImageService < ApplicationService
  class << self

    def conn
      Faraday.new("https://api.teleport.org")
    end

    def get_bg_image(location)
      images_info = get_images_info(location)
      images_link = images_info[:href] + 'images/'
      location_name = images_info[:name]

      images_response = Faraday.get(images_link) #this returns a full href so the conn is not used here.

      formatted_response = json_parse(images_response)[:photos][0]
      formatted_response[:location_name] = location_name
      formatted_response
    end

    private

    def get_images_info(location)
      response = conn.get("/api/locations/#{location.lat},#{location.lon}/")
      json_parse(response)[:_embedded][:"location:nearest-urban-areas"][0][:_links][:"location:nearest-urban-area"]
    end
  end
end
