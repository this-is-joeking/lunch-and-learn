require 'rails_helper'

RSpec.describe 'get learning resources by country' do
  it 'returns a hash of learning resources for the country with a video and 10 images' do
    country = 'guatemala'
    
    WebMock.allow_net_connect!
    # TODO Stub here

    get "/api/v1/learning_resources?country=#{country}"

    learning_data = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response).to have_http_status(200)
    expect(learning_data).to be_a Hash
    expect(learning_data.keys).to eq([:data])
    expect(learning_data[:data]).to be_a Hash
    expect(learning_data[:data].keys.sort).to eq([:id, :type, :attributes].sort)
    expect(learning_data[:data][:id]).to be nil
    expect(learning_data[:data][:type]).to eq('learning_resource')
    expect(learning_data[:data][:attributes]).to be_a Hash
    expect(learning_data[:data][:attributes].keys.sort).to eq([:country, :video, :images].sort)
    expect(learning_data[:data][:attributes][:country]).to eq(country)
    expect(learning_data[:data][:attributes][:video].keys.sort).to eq([:title, :youtube_video_url].sort)
    expect(learning_data[:data][:attributes][:video][:title]).to be_a String
    expect(learning_data[:data][:attributes][:video][:youtube_video_url]).to be_a String
    expect(learning_data[:data][:attributes][:images]).to be_a Array
    learning_data[:data][:attributes][:images].each do |img|
      expect(img.keys.sort).to eq([:alt_tag, :url].sort)
      expect(img[:alt_tag]).to be_a String
      expect(img[:url]).to be_a String      
    end
  end
  
  it 'returns an empty hash if there are no results for queried country' do
    # TODO write test here
  end
end