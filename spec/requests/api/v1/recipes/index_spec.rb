require 'rails_helper'

RSpec.describe 'get recipes by country' do
  it 'returns an array of recipes for the given country' do
    country = 'italy'

    stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=9c81b1a0&app_key=#{ENV['recipe_api_key']}&q=#{country}&type=any")
      .to_return(status: 200, body: File.read('spec/fixtures/recipes_italy.json'), headers: {})

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

  it 'returns an empty array if country param is empty or no results' do
    country = ''

    stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=9c81b1a0&app_key=#{ENV['recipe_api_key']}&q=#{country}&type=any")
      .to_return(status: 200, body: File.read('spec/fixtures/recipes_empty_query.json'), headers: {})

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

    stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=9c81b1a0&app_key=#{ENV['recipe_api_key']}&q=#{country}&type=any")
      .to_return(status: 200, body: File.read('spec/fixtures/recipes_kyrgyzstan.json'), headers: {})

    get "/api/v1/recipes?country=#{country}"

    empty_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(empty_response).to be_a Hash
    expect(empty_response.keys).to eq([:data])
    expect(empty_response[:data]).to eq([])
  end

  it 'gets recipes for a random country if country param is missing' do
    WebMock.disable_net_connect!(allow: 'https://restcountries.com')
  end
end
