require 'rails_helper'

RSpec.describe 'get recipes by country' do
  it 'returns an array of recipes for the given country' do
    country = "italy"

    get "/api/v1/recipes?country=#{country}"

    recipe_data = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(recipe_data).to be_a Hash
    expect(recipe_data.keys).to eq([:data])
    expect(recipe_data[:data]).to be_an Array
    recipe_data[:data].each do |recipe|
      expect(recipe.keys.sort).to eq([:id, :type, :attributes].sort)
      expect(recipe[:id]).to eq(nil)
      expect(recipe[:type]).to eq('recipe')
      expect(recipe[:attributes]).to be_a Hash
      expect(recipe[:attributes].keys.sort).to eq([:title, :url, :country, :image].sort)
      expect(recipe[:attributes][:title]).to be_a String
      expect(recipe[:attributes][:url]).to be_a String
      expect(recipe[:attributes][:country]).to eq('italy')
      expect(recipe[:attributes][:image]).to be_a String
    end
  end
  
  xit 'returns an empty array if country param is empty or no results' do

  end

  xit 'gets recipes for a random country if country param is missing' do

  end
end