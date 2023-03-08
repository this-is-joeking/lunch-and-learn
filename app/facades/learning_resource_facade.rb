class LearningResourceFacade < BaseFacade
  def self.by_country(country)
    if valid?(country)
      video_data = VideoService.search(country)
      images_data = ImageService.search(country)
      LearningResource.new(images_data[:photos], video_data[:items].first, country)
    end
  end
end
