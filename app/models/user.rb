class User < ApplicationRecord
  has_many :favorites

  validates_presence_of :name, :email
  validates_uniqueness_of :email, case_sensitive: false

  after_validation :create_api_key

  private 

  def create_api_key
    self.api_key = SecureRandom.urlsafe_base64(32).tr('-_','')
    # User.find_by(api_key: api_key)
    # require 'pry'; binding.pry
  end

  def insure_uniqueness(key)
    # need to check if key is unique
    # if it is unique assign it to the user
    # if it is not generate new key and try again
    if User.find_by(api_key: key).nil?
    end
  end
end