require 'rails_helper'

RSpec.describe VideoService do
  describe '.search()' do
    it 'returns a video by Mr.History with a title' do
      stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{ENV['YOUTUBE_API_KEY']}&maxResults=1&part=snippet&q=guatemala&type=video")
        .to_return(status: 200, body: File.read('spec/fixtures/youtube_guatemala.json'), headers: {})

      response = VideoService.search('guatemala')

      expect(response).to have_key(:items)
      expect(response[:items].count).to eq(1)
      expect(response[:items][0]).to have_key(:id)
      expect(response[:items][0][:id]).to have_key(:videoId)
      expect(response[:items][0]).to have_key(:snippet)
      expect(response[:items][0][:snippet]).to have_key(:title)
    end
  end
end
