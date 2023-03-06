require 'rails_helper'

RSpec.describe RecipeService do
  describe '.by_country()' do
    it 'returns an array of results matching the queried country' do
      stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=9c81b1a0&app_key=#{ENV['recipe_api_key']}&q=italy&type=any")
        .to_return(status: 200, body: File.read('spec/fixtures/recipes_italy.json'), headers: {})

      response = RecipeService.by_country('italy')

      expect(response).to have_key(:hits)
      expect(response[:hits]).to be_a Array
      response[:hits].each do |result|
        expect(result).to have_key(:recipe)
        expect(result[:recipe]).to have_key(:label)
        expect(result[:recipe]).to have_key(:url)
        expect(result[:recipe]).to have_key(:image)
      end
    end
  end
  
end