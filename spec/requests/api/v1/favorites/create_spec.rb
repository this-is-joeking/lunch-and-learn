require 'rails_helper'

RSpec.describe 'user adding a favorite recipe' do
  it 'adds user favorite when sent valid api key and recipe data' do
    user = create(:user)

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    body = {
      api_key: user.api_key,
      country: 'thailand',
      recipe_link: 'https://www.tastingtable.com/pad_thai',
      recipe_title: 'Pad Thai'
    }
    post '/api/v1/favorites', headers: headers, params: body.to_json

    success_message = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response).to have_http_status(201)
    expect(success_message).to be_a Hash
    expect(success_message).to eq({ success: 'Favorite added successfully' })
    expect(user.favorites.count).to eq(1)
    expect(Favorite.last.country).to eq('thailand')
    expect(Favorite.last.recipe_link).to eq('https://www.tastingtable.com/pad_thai')
    expect(Favorite.last.recipe_title).to eq('Pad Thai')
    expect(Favorite.last.user_id).to eq(user.id)
  end

  it 'responds with an error message if api key is invalid' do
    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    body = {
      api_key: '123asdf6w5eracv19awe',
      country: 'thailand',
      recipe_link: 'https://www.tastingtable.com/pad_thai',
      recipe_title: 'Pad Thai'
    }
    post '/api/v1/favorites', headers: headers, params: body.to_json

    error_message = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response).to have_http_status(401)
    expect(error_message).to be_a Hash
    expect(error_message.keys).to eq([:error])
    expect(error_message[:error].keys.sort).to eq(%i[code message].sort)
    expect(error_message[:error][:code]).to eq(401)
    expect(error_message[:error][:message]).to eq('Not authorized, invalid API Key')
    expect(Favorite.count).to eq(0)
  end

  it 'responds with an error message if a required param is missing' do
    user = create(:user)

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    body = {
      api_key: user.api_key,
      recipe_link: 'https://www.tastingtable.com/pad_thai',
      recipe_title: 'Pad Thai'
    }
    post '/api/v1/favorites', headers: headers, params: body.to_json

    error_message = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response).to have_http_status(422)
    expect(error_message).to be_a Hash
    expect(error_message.keys).to eq([:error])
    expect(error_message[:error].keys.sort).to eq(%i[code message].sort)
    expect(error_message[:error][:code]).to eq(422)
    expect(error_message[:error][:message]).to eq("Validation failed: Country can't be blank")
  end
end
