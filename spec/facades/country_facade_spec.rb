require 'rails_helper'

RSpec.describe CountryFacade do
  describe '.random', :vcr do
    it 'returns a string of a random country' do
      country1 = CountryFacade.random

      expect(country1).to be_a String

      allow(CountryFacade).to receive(:random_num).and_return(0)

      country2 = CountryFacade.random

      expect(country2).to eq('Niue')
    end
  end
end
