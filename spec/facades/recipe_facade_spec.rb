require 'rails_helper'

RSpec.describe RecipeFacade do
  describe '.by_country()', :vcr do
    it 'returns recipe objects for the given country' do
      country = 'italy'

      recipes = RecipeFacade.by_country(country)

      recipes.each do |recipe|
        expect(recipe).to be_a Recipe
        expect(recipe.country).to eq(country)
      end
    end
  end

  describe '.random_country', :vcr do
    it 'returns a string of a random country' do
      country1 = RecipeFacade.random_country

      expect(country1).to be_a String

      allow(RecipeFacade).to receive(:random_num).and_return(0)

      country2 = RecipeFacade.random_country

      expect(country2).to eq('Niue')
    end
  end
end
