require 'rails_helper'

RSpec.describe 'Tourist sights' do
  describe 'get /api/v1/tourist_sights?country=<country name>' do
    it 'returns a collection of tourist sights within 20,000 m of country capital' do

      get '/api/v1/tourist_sights?country=france'

      sights_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(sights_data).to be_a Hash
      expect(sights_data.keys).to eq(:data)
      sights_data[:data].each do |sight|
        expect(sight.keys.sort).to eq([:id, :type, :attributes].sort)
        expect(sight[:id]).to eq(nil)
        expect(sight[:type]).to eq('tourist_sight')
        expect(sight[:attributes].keys.sort).to eq([:name, :address, :place_id])
        expect(sight[:attributes][:name]).to be_a String
        expect(sight[:attributes][:address]).to be_a String
        expect(sight[:attributes][:place_id]).to be_a String
      end
    end
  end
end