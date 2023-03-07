require 'rails_helper'

RSpec.describe ImageService do
  describe '.search()', :vcr do
    it 'returns an 10 image results with a url and alt text' do
      response = ImageService.search('guatemala')

      expect(response).to have_key(:photos)
      expect(response[:photos].count).to eq(10)
      response[:photos].each do |photo_data|
        expect(photo_data).to be_a Hash
        expect(photo_data).to have_key(:src)
        expect(photo_data[:src]).to have_key(:original)
        expect(photo_data).to have_key(:alt)
      end
    end
  end
end
