class LearningResourceFacade
  def self.by_country(country)
    video_data = VideoService.search(country)
    images_data = ImageService.search(country)
    # TODO for alt text need to privde alt text and photo attribution where possible
    require 'pry'; binding.pry
    # TODO make sure to send right data to poro below
    LearningResource.new(images_data, video_data[:items].first, country)
    # video_id = [:id][:videoId]
    # video_tile = [:snippet][:title]
  end
end