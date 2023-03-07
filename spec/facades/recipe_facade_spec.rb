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
end
