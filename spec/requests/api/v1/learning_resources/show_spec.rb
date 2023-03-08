require 'rails_helper'

RSpec.describe 'get learning resources by country', :vcr do
  it 'returns a hash of learning resources for the country with a video and 10 images' do
    country = 'guatemala'

    get "/api/v1/learning_resources?country=#{country}"

    learning_data = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response).to have_http_status(200)
    expect(learning_data).to be_a Hash
    expect(learning_data.keys).to eq([:data])
    expect(learning_data[:data]).to be_a Hash
    expect(learning_data[:data].keys.sort).to eq(%i[id type attributes].sort)
    expect(learning_data[:data][:id]).to be nil
    expect(learning_data[:data][:type]).to eq('learning_resource')
    expect(learning_data[:data][:attributes]).to be_a Hash
    expect(learning_data[:data][:attributes].keys.sort).to eq(%i[country video images].sort)
    expect(learning_data[:data][:attributes][:country]).to eq(country)
    expect(learning_data[:data][:attributes][:video].keys.sort).to eq(%i[title youtube_video_id].sort)
    expect(learning_data[:data][:attributes][:video][:title]).to be_a String
    expect(learning_data[:data][:attributes][:video][:youtube_video_id]).to be_a String
    expect(learning_data[:data][:attributes][:images]).to be_a Array
    learning_data[:data][:attributes][:images].each do |img|
      expect(img.keys.sort).to eq(%i[alt_tag url].sort)
      expect(img[:alt_tag]).to be_a String
      expect(img[:url]).to be_a String
    end
  end

  it 'returns an empty array for images if there are no image resutls' do
    country = 'nauru'

    get "/api/v1/learning_resources?country=#{country}"

    learning_data = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response).to have_http_status(200)
    expect(learning_data).to be_a Hash
    expect(learning_data.keys).to eq([:data])
    expect(learning_data[:data]).to be_a Hash
    expect(learning_data[:data].keys.sort).to eq(%i[id type attributes].sort)
    expect(learning_data[:data][:id]).to be nil
    expect(learning_data[:data][:type]).to eq('learning_resource')
    expect(learning_data[:data][:attributes]).to be_a Hash
    expect(learning_data[:data][:attributes].keys.sort).to eq(%i[country video images].sort)
    expect(learning_data[:data][:attributes][:country]).to eq(country)
    expect(learning_data[:data][:attributes][:video].keys.sort).to eq(%i[title youtube_video_id].sort)
    expect(learning_data[:data][:attributes][:video][:title]).to be_a String
    expect(learning_data[:data][:attributes][:video][:youtube_video_id]).to be_a String
    expect(learning_data[:data][:attributes][:images]).to eq([])
  end

  it 'returns empty hash for video if there are no video results' do
    country = 'suriname'

    get "/api/v1/learning_resources?country=#{country}"

    learning_data = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response).to have_http_status(200)
    expect(learning_data).to be_a Hash
    expect(learning_data.keys).to eq([:data])
    expect(learning_data[:data]).to be_a Hash
    expect(learning_data[:data].keys.sort).to eq(%i[id type attributes].sort)
    expect(learning_data[:data][:id]).to be nil
    expect(learning_data[:data][:type]).to eq('learning_resource')
    expect(learning_data[:data][:attributes]).to be_a Hash
    expect(learning_data[:data][:attributes].keys.sort).to eq(%i[country video images].sort)
    expect(learning_data[:data][:attributes][:country]).to eq(country)
    expect(learning_data[:data][:attributes][:video]).to eq({})
    expect(learning_data[:data][:attributes][:images]).to be_a Array
    learning_data[:data][:attributes][:images].each do |img|
      expect(img.keys.sort).to eq(%i[alt_tag url].sort)
      expect(img[:alt_tag]).to be_a String
      expect(img[:url]).to be_a String
    end
  end

  xit 'returns an error message if country param is not a country' do
    # TODO validate that a country param is a country
    country = 'asdfasdf'

    get "/api/v1/learning_resources?country=#{country}"

    error_message = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response).to have_http_status(400)
    expect(error_message).to be_a Hash
    expect(error_message.keys).to eq([:error])
    expect(error_message[:error].keys.sort).to eq(%i[code message].sort)
    expect(error_message[:error][:code]).to eq(400)
    expect(error_message[:error][:message]).to eq('Invalid request, no value for country param given')
  end

  it 'returns an error message if country param is missing' do
    get "/api/v1/learning_resources"

    error_message = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response).to have_http_status(400)
    expect(error_message).to be_a Hash
    expect(error_message.keys).to eq([:error])
    expect(error_message[:error].keys.sort).to eq(%i[code message].sort)
    expect(error_message[:error][:code]).to eq(400)
    expect(error_message[:error][:message]).to eq('Invalid request, no country param given')
  end
end
