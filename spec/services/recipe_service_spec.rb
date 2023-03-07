require 'rails_helper'

RSpec.describe RecipeService do
  describe '.by_country()', :vcr do
    it 'returns an array of results matching the queried country' do
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
