require 'rails_helper'

RSpec.describe ImageService do
  describe '.search()' do
    it 'returns an 10 image results with a url and alt text' do
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