class ApiKey < ApplicationRecord
  belongs_to :user

  validates :token, presence: true, uniqueness: true, length: { is: 32 }
end
