require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:token) }
    it { should validate_uniqueness_of(:token) }
    it { should validate_length_of(:token).is_equal_to(32) }
  end

  describe 'factories' do
    describe 'create(:api_key)' do
      subject(:api_key) { create(:api_key) }

      it 'creates a valid object' do
        expect(api_key).to be_valid
      end
    end
  end

  describe 'class methods' do
    describe '#get_user_token' do
      it 'returns the first token' do
        first_api_key = create(:user).api_keys.first
        second_api_key = create(:user).api_keys.first
        third_api_key = create(:user).api_keys.first

        expect(ApiKey.get_user_token).to eq(first_api_key.token)
        expect(ApiKey.get_user_token).not_to eq(second_api_key.token)
        expect(ApiKey.get_user_token).not_to eq(third_api_key.token)

        expect(ApiKey.get_user_token).to be_a(String)
        expect(ApiKey.get_user_token.length).to eq(32)
      end
    end
  end
end
