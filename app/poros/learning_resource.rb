class LearningResource
  attr_reader :id, :country, :video
  def initialize(images_data, video_data, country)
    @id = nil
    @country = country
    @video = { title: video_data[:snippet][:title], 
               youtube_video_id: video_data[:id][:videoId] }
    @images_data = images_data
  end

  def images
    @images_data.map do |image_data|
      {
        alt_tag: image_data[:alt],
        url: image_data[:src][:original]
      }
    end
  end
end
