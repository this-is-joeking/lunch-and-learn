require 'rails_helper'

RSpec.describe 'creating a new user' do
  it 'receives a post request, creates user, sends back api key' do
    name = Faker::TvShows::BojackHorseman.character
    email = Faker::Internet.email(name: name)

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    body = {
      name: name,
      email: email
    }
    post '/api/v1/users', headers: headers, params: body.to_json

    new_user = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response).to have_http_status(201)
    expect(new_user).to be_a Hash
    expect(new_user.keys).to eq([:data])
    expect(new_user[:data]).to be_a Hash
    expect(new_user[:data].keys.sort).to eq(%i[type id attributes].sort)
    expect(new_user[:data][:type]).to eq('user')
    expect(new_user[:data][:id]).to be_a String
    expect(new_user[:data][:id].to_i).to be_a Integer
    expect(new_user[:data][:attributes]).to be_a Hash
    expect(new_user[:data][:attributes].keys.sort).to eq(%i[name email api_key].sort)
    expect(new_user[:data][:attributes][:name]).to eq(name)
    expect(new_user[:data][:attributes][:email]).to eq(email)
    expect(new_user[:data][:attributes][:api_key]).to be_a String
    # TODO: once api key generation is place consider more thorough testing of the key value
  end

  it 'sends a error response if user with email already exists' do
    user1 = create(:user)
    name = 'john'
    email = user1.email

    headers = {
      'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    body = {
      name: name,
      email: email
    }
    post '/api/v1/users', headers: headers, params: body.to_json

    error_data = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response).to have_http_status(422)
    expect(error_data).to be_a Hash
    expect(error_data.keys).to eq([:error])
    expect(error_data[:error].keys.sort).to eq(%i[code message])
    expect(error_data[:error][:code]).to eq(422)
    expect(error_data[:error][:message]).to eq('Validation failed: Email has already been taken')
  end
end
