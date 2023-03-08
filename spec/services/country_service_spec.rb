require 'rails_helper'

RSpec.describe CountryService do
  describe '.all' do
    it 'gets all countries', :vcr do
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
    it 'returns the status code for querying the countries full name' do
      expect(CountryService.find('germany')).to eq(200)
      expect(CountryService.find('GERMAny')).to eq(200)
      expect(CountryService.find('greece')).to eq(200)
      expect(CountryService.find('notacountry')).to eq(404)
    end
  end
end
