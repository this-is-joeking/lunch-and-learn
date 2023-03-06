require 'rails_helper'

RSpec.describe TouristSight do
  it 'exists with attributes' do
    sight_data = { type: 'Feature',
                   properties:        { name: 'Palais du Louvre',
         formatted: 'Louvre Palace, Avenue du Général Lemonnier, 75001 Paris, France',
         place_id: '518d1bce0ed2af02405927f526f2356e4840f00101f90159c731000000000092031050616c616973206475204c6f75767265' } }

    sight = TouristSight.new(sight_data)

    expect(sight).to be_a TouristSight
    expect(sight.id).to eq nil
    expect(sight.name).to eq('Palais du Louvre')
    expect(sight.address).to eq('Louvre Palace, Avenue du Général Lemonnier, 75001 Paris, France')
    expect(sight.place_id).to eq('518d1bce0ed2af02405927f526f2356e4840f00101f90159c731000000000092031050616c616973206475204c6f75767265')
  end
end
