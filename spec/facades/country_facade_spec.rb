require 'rails_helper'

RSpec.describe CountryFacade do
  describe '.random' do
    it 'returns a string of a random country' do
      stub_request(:get, 'https://restcountries.com/v3.1/all')
        .to_return(status: 200, body: File.read('spec/fixtures/all_countries.json'), headers: {})

      country1 = CountryFacade.random

      expect(country1).to be_a String

      allow(CountryFacade).to receive(:random_num).and_return(0)

      country2 = CountryFacade.random

      expect(country2).to eq('Gambia')
    end
  end

  describe '.capital_coordinates()' do
    it 'returns a hash of capital latitude and longitude' do
      stub_request(:get, 'https://restcountries.com/v3.1/name/france')
        .to_return(status: 200, body: File.read('spec/fixtures/find_france.json'))

      lat_lon = CountryFacade.capital_coordinates('france')

      expect(lat_lon).to eq({ latitude: 48.87, longitude: 2.33 })
    end
  end
end
