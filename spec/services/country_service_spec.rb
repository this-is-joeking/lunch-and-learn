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
end
