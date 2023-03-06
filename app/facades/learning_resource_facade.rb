class LearningResourceFacade
  def self.by_country(country)
    video_data = VideoService.search(country)
    images_data = ImageService.search(country)
    LearningResource.new(images_data, video_data[:items].first, country)
  end
end