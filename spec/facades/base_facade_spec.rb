require 'rails_helper'

RSpec.describe BaseFacade do
  describe '.valid?()' do
    it 'checks if the given parameter is a valid country per country service' do
      expect(BaseFacade.valid?('italy')).to be true
      expect(BaseFacade.valid?('ItAlY')).to be true
      expect(BaseFacade.valid?('Spain')).to be true
      expect(BaseFacade.valid?('gibbersih')).to be false
    end
  end
end