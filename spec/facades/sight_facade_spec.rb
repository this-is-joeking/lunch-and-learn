require 'rails_helper'

RSpec.describe SightFacade do
  it 'returns tourist sight objects' do
    stub_request(:get, "https://api.geoapify.com/v2/places?apiKey=#{ENV['places_api_key']}&categories=tourism.sights&filter=circle:2.33,48.87,1000")
        .to_return(status: 200, body: File.read('spec/fixtures/paris_sights.json'))
        
    sights = SightFacade.sights_near(2.33, 48.87)

    sights.each do |sight|
      expect(sight).to be_a TouristSight
    end
  end
end