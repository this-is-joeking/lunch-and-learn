require 'rails_helper'

RSpec.describe 'get recipes by country', :vcr do
  it 'returns an array of recipes for the given country' do
    country = 'italy'

    get "/api/v1/recipes?country=#{country}"

    recipe_data = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(recipe_data).to be_a Hash
    expect(recipe_data.keys).to eq([:data])
    expect(recipe_data[:data]).to be_an Array
    recipe_data[:data].each do |recipe|
      expect(recipe.keys.sort).to eq(%i[id type attributes].sort)
      expect(recipe[:id]).to eq(nil)
      expect(recipe[:type]).to eq('recipe')
      expect(recipe[:attributes]).to be_a Hash
      expect(recipe[:attributes].keys.sort).to eq(%i[title url country image].sort)
      expect(recipe[:attributes][:title]).to be_a String
      expect(recipe[:attributes][:url]).to be_a String
      expect(recipe[:attributes][:country]).to eq('italy')
      expect(recipe[:attributes][:image]).to be_a String
    end
  end

  it 'returns an empty array if country param is empty or no results' do
    country = ''

    get "/api/v1/recipes?country=#{country}"

    empty_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(empty_response).to be_a Hash
    expect(empty_response.keys).to eq([:data])
    expect(empty_response[:data]).to eq([])
  end

  it 'returns an empty array if there are no results' do
    country = 'Kyrgyzstan'

    get "/api/v1/recipes?country=#{country}"

    empty_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(empty_response).to be_a Hash
    expect(empty_response.keys).to eq([:data])
    expect(empty_response[:data]).to eq([])
  end

  it 'gets recipes for a random country if country param is missing' do
    allow(CountryFacade).to receive(:random).and_return('italy')

    get '/api/v1/recipes'

    recipe_data = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(recipe_data).to be_a Hash
    expect(recipe_data.keys).to eq([:data])
    expect(recipe_data[:data]).to be_an Array
    recipe_data[:data].each do |recipe|
      expect(recipe.keys.sort).to eq(%i[id type attributes].sort)
      expect(recipe[:id]).to eq(nil)
      expect(recipe[:type]).to eq('recipe')
      expect(recipe[:attributes]).to be_a Hash
      expect(recipe[:attributes].keys.sort).to eq(%i[title url country image].sort)
      expect(recipe[:attributes][:title]).to be_a String
      expect(recipe[:attributes][:url]).to be_a String
      expect(recipe[:attributes][:country]).to eq('italy')
      expect(recipe[:attributes][:image]).to be_a String
    end
  end
end
