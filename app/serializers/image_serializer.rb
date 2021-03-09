class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :image_url, :source, :author
  set_id {nil}
end
