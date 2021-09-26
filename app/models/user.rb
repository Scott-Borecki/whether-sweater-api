class User < ApplicationRecord
  has_many :api_keys, dependent: :destroy

  validates :email, uniqueness: true, presence: true
  validates :password_confirmation, presence: true

  after_commit :generate_api_key, on: :create

  has_secure_password

  def api_key
    api_keys.user_token
  end

  private

  def generate_api_key
    ApiKey.create!(user: self, token: SecureRandom.hex)
  end
end
