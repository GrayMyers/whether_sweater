require "rails_helper"

describe ImageService do
  describe "get_bg_image" do
    describe "happy path" do
      it "gets an image when prompted with coordinates" do
        location = Location.new(lat: 39.74,lng: -104.94)

        json_response = File.read('./spec/fixtures/get_bg_image_spec/get_nearest_city.json')
        stub_request(:get, "https://api.teleport.org/api/locations/39.74,-104.94/")
          .to_return(status: 200, body: json_response)

          json_response = File.read('./spec/fixtures/get_bg_image_spec/get_images.json')
          stub_request(:get, "https://api.teleport.org/api/urban_areas/slug:denver/images/")
            .to_return(status: 200, body: json_response)

        image_data = ImageService.get_bg_image(location)
        expect(image_data[:attribution][:photographer]).to eq("Sheila Sund")
        expect(image_data[:attribution][:site]).to eq("Flickr")
        expect(image_data[:attribution][:image][:web]).to eq("https://d13k13wj6adfdf.cloudfront.net/urban_areas/denver_web-9726d88300.jpg")
      end
    end

    describe "sad path" do

    end
  end
end
