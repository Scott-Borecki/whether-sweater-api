class User < ApplicationRecord
  has_many :api_keys

  validates :email, uniqueness: true, presence: true

  has_secure_password
end
