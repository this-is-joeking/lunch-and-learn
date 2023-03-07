require 'rails_helper'

RSpec.describe VideoService do
  describe '.search()', :vcr do
    it 'returns a video by Mr.History with a title' do
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
