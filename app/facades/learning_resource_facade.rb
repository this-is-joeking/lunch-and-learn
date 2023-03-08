class LearningResourceFacade
  def self.by_country(country)
    if valid?(country)
      video_data = VideoService.search(country)
      images_data = ImageService.search(country)
      LearningResource.new(images_data[:photos], video_data[:items].first, country)
    else
      nil
    end
  end

  def self.valid?(country)
    country_data = CountryService.find(country)
    country_data == 200
  end
end
