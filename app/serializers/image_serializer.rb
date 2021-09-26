class ImageSerializer
  include JSONAPI::Serializer

  set_id :id
  attributes :image
end
