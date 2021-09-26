FactoryBot.define do
  factory :api_key do
    token { SecureRandom.hex }
    user
  end
end
