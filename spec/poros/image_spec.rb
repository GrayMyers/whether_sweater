require "rails_helper"

describe Image do
  it "exists and has attributes" do
    data = {:attribution=>{:license=>"Attribution, ShareAlike", :photographer=>"Sheila Sund", :site=>"Flickr", :source=>"https://www.flickr.com/photos/sheila_sund/8903465080/"},
 :image=>{:mobile=>"https://d13k13wj6adfdf.cloudfront.net/urban_areas/denver-655725fd8b.jpg", :web=>"https://d13k13wj6adfdf.cloudfront.net/urban_areas/denver_web-9726d88300.jpg"},
 :location_name=>"Denver"}

    image = Image.new(data)
    expect(image).to be_an Image
    expect(image.location).to eq(data[:location_name])
    expect(image.image_url).to eq(data[:image][:web])
    expect(image.author).to eq(data[:attribution][:photographer])
    expect(image.source).to eq(data[:attribution][:site])
  end
end
