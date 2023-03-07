require 'rails_helper'

RSpec.describe LearningResourceFacade do
  describe '.by_country()', :vcr do
    it 'returns a LearningResource object' do
      lr = LearningResourceFacade.by_country('guatemala')

      expect(lr).to be_a LearningResource
    end
  end
end
