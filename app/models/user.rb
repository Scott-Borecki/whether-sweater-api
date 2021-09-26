class User < ApplicationRecord
  has_many :api_keys

  validates :email, uniqueness: true, presence: true

  after_commit :generate_api_key, on: :create

  has_secure_password

  private

  def generate_api_key
    ApiKey.create!(user: self, token: SecureRandom.hex)
  end
end
