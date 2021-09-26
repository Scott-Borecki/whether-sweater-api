FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Alphanumeric.alpha(number: 10) }
    password_confirmation { password }
  end
end
