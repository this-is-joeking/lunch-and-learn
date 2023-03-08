require 'rails_helper'
require 'validates_email_format_of/rspec_matcher'

RSpec.describe User do
  describe 'relationships' do
    it { should have_many :favorites }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of :name }
    it { should validate_email_format_of(:email).with_message('is invalid') }
  end

  describe '#create_api_key' do
    it 'assigns the unique and random api key to the user' do
      user = User.create!(name: 'John', email: 'John@doe.com')

      expect(user.api_key).to be_a String
    end
  end
end
