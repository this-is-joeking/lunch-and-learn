require 'rails_helper'

RSpec.describe SightService do
  it 'returns an array of data needed to make TouristSite objects' do
    stub_request(:get, "https://api.geoapify.com/v2/places?apiKey=#{ENV['places_api_key']}&categories=tourism.sights&filter=circle:2.33,48.87,1000")
      .to_return(status: 200, body: File.read('spec/fixtures/paris_sights.json'))

    sights_data = SightService.sights_near(2.33, 48.87)

    expect(sights_data).to be_a Hash
    expect(sights_data[:features]).to be_a Array
    expect(sights_data[:features].first).to have_key(:properties)
    expect(sights_data[:features][0][:properties]).to have_key(:name)
    expect(sights_data[:features][0][:properties]).to have_key(:formatted)
    expect(sights_data[:features][0][:properties]).to have_key(:place_id)
  end
end
