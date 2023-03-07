class LearningResourceSerializer
  include JSONAPI::Serializer
  attributes :country, :images, :video
end
