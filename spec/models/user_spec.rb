require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:api_keys) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_most(72) }
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
end
