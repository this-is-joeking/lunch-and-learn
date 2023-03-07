require 'rails_helper'

RSpec.describe LearningResourceFacade do
  describe '.by_country()' do
    it 'returns a LearningResource object' do
    stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{ENV['YOUTUBE_API_KEY']}&maxResults=1&part=snippet&q=guatemala&type=video")
      .to_return(status: 200, body: File.read('spec/fixtures/youtube_guatemala.json'), headers: {})

    stub_request(:get, 'https://api.pexels.com/v1/search?per_page=10&query=guatemala')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => ENV['PEXELS_API_KEY'],
          'User-Agent' => 'Faraday v2.7.4'
        }
      )
      .to_return(status: 200, body: File.read('spec/fixtures/pexel_guatemala.json'), headers: {})

      lr = LearningResourceFacade.by_country('guatemala')

      expect(lr).to be_a LearningResource
    end
  end
end