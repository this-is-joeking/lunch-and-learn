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
end
