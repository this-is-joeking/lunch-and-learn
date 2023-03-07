require 'rails_helper'

RSpec.describe 'get learning resources by country' do
  it 'returns a hash of learning resources for the country with a video and 10 images' do
    country = 'guatemala'

    stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{ENV['YOUTUBE_API_KEY']}&maxResults=1&part=snippet&q=guatemala&type=video")
      .to_return(status: 200, body: File.read('spec/fixtures/youtube_guatemala.json'), headers: {})

    stub_request(:get, 'https://api.pexels.com/v1/search?per_page=10&query=guatemala')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => ENV['PEXELS_API_KEY'],
          'User-Agent' => 'Faraday v2.7.4'
        }
      )
      .to_return(status: 200, body: File.read('spec/fixtures/pexel_guatemala.json'), headers: {})

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
    WebMock.allow_net_connect!
    
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
    WebMock.allow_net_connect!

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
end
