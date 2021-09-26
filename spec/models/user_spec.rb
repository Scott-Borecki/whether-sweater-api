require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:api_keys).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
    it { should validate_length_of(:password).is_at_most(72) }
    it { should validate_presence_of(:password_confirmation) }
  end

  describe 'call backs' do
    describe 'after_commit' do
      describe 'on: :create' do
        describe '#generate_api_key' do
          subject(:user) { create(:user) }

          it 'generates an api key for the new user' do
            expect(user.api_keys.size).to eq(1)
            expect(user.api_keys.first.token).to be_a(String)
          end
        end
      end
    end
  end

  describe 'factories' do
    describe 'create(:user)' do
      subject(:user) { create(:user) }

      it 'creates a valid object' do
        expect(user).to be_valid
      end
    end
  end

  describe 'instance methods' do
    describe '#api_key' do
      subject(:user) { create(:user) }

      let(:api_key_token) { user.api_keys.first.token }

      it 'returns the users api key (token)' do
        expect(user.api_key).to eq(api_key_token)
      end
    end
  end
end
