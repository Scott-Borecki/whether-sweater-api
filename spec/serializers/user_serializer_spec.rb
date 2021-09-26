require 'rails_helper'

describe UserSerializer, type: :serializer do
  describe 'object creation' do
    subject(:user_serializer) { UserSerializer.new(user) }

    let(:user) { create(:user) }

    it 'is valid and has readable attributes' do
      expect(user_serializer).to be_a(UserSerializer)
    end
  end

  describe 'instance methods' do
    describe '#serializable_hash' do
      subject(:user_hash) { UserSerializer.new(user).serializable_hash }

      let(:user) { create(:user) }

      it 'returns a JSON:API compliable hash', :aggregate_failures do
        expect(user_hash).to be_a(Hash)

        expect(user_hash).to have_key(:data)
        expect(user_hash[:data]).to be_a(Hash)
        expect(user_hash[:data].size).to eq(3)

        expect(user_hash[:data]).to have_key(:id)
        expect(user_hash[:data][:id]).to be_a(String)
        expect(user_hash[:data][:id]).to eq(user.id.to_s)

        expect(user_hash[:data]).to have_key(:type)
        expect(user_hash[:data][:type]).to eq(:user)

        expect(user_hash[:data]).to have_key(:attributes)
        expect(user_hash[:data][:attributes]).to be_a(Hash)
        expect(user_hash[:data][:attributes].size).to eq(2)

        expect(user_hash[:data][:attributes]).to have_key(:email)
        expect(user_hash[:data][:attributes][:email]).to be_a(String)
        expect(user_hash[:data][:attributes][:email]).to eq(user.email)

        expect(user_hash[:data][:attributes]).to have_key(:api_key)
        expect(user_hash[:data][:attributes][:api_key]).to be_a(String)
        expect(user_hash[:data][:attributes][:api_key]).to eq(user.api_key)
      end
    end
  end
end
