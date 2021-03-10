class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :image_url, :source, :author
  
  attribute :site do
    "Source: Teleport (teleport.org)"
  end
  set_id {nil}
end
