require "rails_helper"

describe ImageFacade do
  describe "get_image" do
    describe "happy_path" do
      it "returns an image poro" do
        location = Location.new(lat: 39.74,lng: -104.94)

        json_response = File.read('./spec/fixtures/get_bg_image_spec/get_nearest_city.json')
        stub_request(:get, "https://api.teleport.org/api/locations/39.74,-104.94/")
          .to_return(status: 200, body: json_response)

        json_response = File.read('./spec/fixtures/get_bg_image_spec/get_images.json')
        stub_request(:get, "https://api.teleport.org/api/urban_areas/slug:denver/images/")
          .to_return(status: 200, body: json_response)

        image = ImageFacade.get_image(location)
        expect(image).to be_an Image
      end
    end

    describe "sad_path" do

    end
  end
end
