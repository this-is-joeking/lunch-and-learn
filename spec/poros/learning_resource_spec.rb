require 'rails_helper'

RSpec.describe LearningResource do
  before(:each) do
      
    @images = [{:id=>335887,
      :url=>"https://www.pexels.com/photo/aerial-view-of-a-city-335887/",
      :src=>
      {:original=>"https://images.pexels.com/photos/335887/pexels-photo-335887.jpeg",
        :tiny=>"https://images.pexels.com/photos/335887/pexels-photo-335887.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"},
        :liked=>false,
        :alt=>"Aerial View of a City"},
        {:id=>2661176,
          :url=>"https://www.pexels.com/photo/lake-atitlan-2661176/",
          :src=>
          {:original=>"https://images.pexels.com/photos/2661176/pexels-photo-2661176.jpeg",
            :tiny=>"https://images.pexels.com/photos/2661176/pexels-photo-2661176.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"},
            :liked=>false,
            :alt=>"Lake Atitlán"}]
    @video = {:kind=>"youtube#searchResult",
      :id=>{:kind=>"youtube#video", :videoId=>"Gl1TY5hQO78"},
      :snippet=>
      {:publishedAt=>"2020-10-13T08:39:31Z",
        :title=>"A Super Quick History of Guatemala",
        :publishTime=>"2020-10-13T08:39:31Z"}}
                
    @country = 'guatemala'
    
    @learning_resource = LearningResource.new(@images, @video, @country)
  end
              
  it 'exists with attributes' do
    expect(@learning_resource).to be_a LearningResource
    expect(@learning_resource.id).to eq(nil)
    expect(@learning_resource.country).to eq(@country)
    expect(@learning_resource.video[:title]).to eq('A Super Quick History of Guatemala')
    expect(@learning_resource.video[:youtube_video_id]).to eq('Gl1TY5hQO78')
  end

  describe '#images' do
    it 'returns an array of hashes with the alt text and img url' do
      images = @learning_resource.images
      
      expect(images).to be_a Array
      images.each do |image|
        expect(image.keys.sort).to eq([:alt_tag, :url])
      end
      expect(images[0][:alt_tag]).to eq('Aerial View of a City')
      expect(images[0][:url]).to eq('https://images.pexels.com/photos/335887/pexels-photo-335887.jpeg')
    end
  end
end
