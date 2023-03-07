require 'rails_helper'

RSpec.describe CountryService do
  describe '.all' do
    it 'gets all countries' do
      stub_request(:get, 'https://restcountries.com/v3.1/all')
        .to_return(status: 200, body: File.read('spec/fixtures/all_countries.json'), headers: {})

      response = CountryService.all

      expect(response).to be_a Array
      response.each do |country|
        expect(country).to have_key(:name)
        expect(country[:name]).to have_key(:common)
        expect(country[:name][:common]).to be_a String
      end
    end
  end
end
