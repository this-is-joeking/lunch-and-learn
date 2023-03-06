require 'rails_helper'

RSpec.describe CountryService do
  describe '.all' do
    it 'gets all countries' do
      stub_request(:get, "https://restcountries.com/v3.1/all")
        .to_return(status: 200, body: File.read("spec/fixtures/all_countries.json"), headers: {})

      response = CountryService.all

      expect(response).to be_a Array
      response.each do |country|
        expect(country).to have_key(:name)
        expect(country[:name]).to have_key(:common)
        expect(country[:name][:common]).to be_a String
      end
    end
  end

  describe '.find()' do
    it 'returns data for given country including coordinates of capital' do
      stub_request(:get, "https://restcountries.com/v3.1/name/france")
       .to_return(status: 200, body: File.read('spec/fixtures/find_france.json'))

      country_details = CountryService.find('france')

      expect(country_details).to be_a Array
      expect(country_details.first).to have_key(:capitalInfo)
      expect(country_details.first[:capitalInfo]).to have_key(:latlng)
      expect(country_details.first[:capitalInfo][:latlng]).to be_a Array
      expect(country_details.first[:capitalInfo][:latlng][0]).to be_a Float
      expect(country_details.first[:capitalInfo][:latlng][1]).to be_a Float
    end
  end
end