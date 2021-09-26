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
end
