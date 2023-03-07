class User < ApplicationRecord
  has_many :favorites

  validates_presence_of :name, :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_uniqueness_of :api_key

  before_create :create_api_key

  private 

  def create_api_key
    loop do
      self.api_key = SecureRandom.urlsafe_base64(32).tr('-_','')
      break unless User.find_by(api_key: self.api_key)
    end
  end
end