require 'rails_helper'

RSpec.describe RecipeFacade do
  describe '.by_country()' do
    it 'returns recipe objects for the given country' do
      country = 'italy'

      stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=9c81b1a0&app_key=#{ENV['recipe_api_key']}&q=#{country}&type=any")
        .to_return(status: 200, body: File.read('spec/fixtures/recipes_italy.json'), headers: {})

      recipes = RecipeFacade.by_country(country)

      recipes.each do |recipe|
        expect(recipe).to be_a Recipe
        expect(recipe.country).to eq(country)
      end
    end
  end
end