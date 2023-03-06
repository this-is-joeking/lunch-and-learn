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
        alt_tag: extract_alt_text(image_data[:url]),
        url: image_data[:src][:original]
      }
    end
  end

  def extract_alt_text(url)
    alt_text = url.split('/').last # gets only the end of the URL
    alt_text.gsub(/\d+$/, '') # removes the # at end of the url
  end
end
