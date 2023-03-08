require 'rails_helper'

RSpec.describe 'list all of a users favorites' do
  it 'returns favorites when given valid api key' do
    user = create(:user)

    5.times do
      create(:favorite, user_id: user.id)
    end

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    get '/api/v1/favorites', headers: headers, params: { api_key: user.api_key }

    favorites_data = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response).to have_http_status(200)
    expect(favorites_data).to be_a Hash
    expect(favorites_data.keys).to eq([:data])
    expect(favorites_data[:data]).to be_a Array
    expect(favorites_data[:data].length).to eq(5)
    favorites_data[:data].each do |favorite_data|
      expect(favorite_data).to be_a Hash
      expect(favorite_data.keys.sort).to eq(%i[id type attributes].sort)
      expect(favorite_data[:id]).to be_a String
      expect(favorite_data[:id].to_i).to be_a Integer
      expect(Favorite.find(favorite_data[:id].to_i)).to_not be(nil)
      expect(favorite_data[:type]).to eq('favorite')
      expect(favorite_data[:attributes]).to be_a Hash
      expect(favorite_data[:attributes].keys.sort).to eq(%i[recipe_title recipe_link country created_at].sort)
      expect(favorite_data[:attributes][:recipe_title]).to be_a String
      expect(favorite_data[:attributes][:recipe_link]).to be_a String
      expect(favorite_data[:attributes][:country]).to be_a String
      expect(favorite_data[:attributes][:created_at]).to be_a String
      expect(favorite_data[:attributes][:created_at].to_datetime).to be_a DateTime
    end
  end

  it 'returns an empty array if there are no faves for the user' do
    user = create(:user)

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    get '/api/v1/favorites', headers: headers, params: { api_key: user.api_key }

    favorites_data = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response).to have_http_status(200)
    expect(favorites_data).to be_a Hash
    expect(favorites_data.keys).to eq([:data])
    expect(favorites_data[:data]).to eq([])
  end

  it 'returns an error message if given an invalid api key' do
    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    get '/api/v1/favorites', headers: headers, params: { api_key: 'gaf6g7af6v4as6d8f7asdf4' }

    error_message = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response).to have_http_status(401)
    expect(error_message).to be_a Hash
    expect(error_message.keys).to eq([:error])
    expect(error_message[:error].keys.sort).to eq(%i[code message].sort)
    expect(error_message[:error][:code]).to eq(401)
    expect(error_message[:error][:message]).to eq('Not authorized, invalid API Key')
  end
end
