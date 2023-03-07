class LearningResource
  attr_reader :id, :country

  def initialize(images_data, video_data, country)
    @id          = nil
    @country     = country
    @video_data  = video_data
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

  def video
    if @video_data
      { title: @video_data[:snippet][:title],
        youtube_video_id: @video_data[:id][:videoId] }
    else
      {}
    end
  end
end
