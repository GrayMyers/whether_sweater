class Image
  attr_reader :source, :author, :image_url, :location

  def initialize(data)
    @source = data[:attribution][:site]
    @author = data[:attribution][:photographer]
    @image_url = data[:image][:web]
    @location = data[:location_name]
  end
end
