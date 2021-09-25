require 'rails_helper'

describe ErrorSerializer, type: :serializer do
  describe 'object creation' do
    subject(:error_serializer) { ErrorSerializer.new(error_response) }

    let(:error_response) do
      {
        status: 400,
        messages: ['some error message',
                   'another error message',
                   'and another error message']
      }
    end

    it 'is valid and has readable attributes', :aggregate_failures do
      expect(error_serializer).to be_an(ErrorSerializer)
      expect(error_serializer.status).to eq(error_response[:status])
      expect(error_serializer.messages).to eq(error_response[:messages])
    end
  end

  describe 'instance methods' do
    describe '#to_hash' do
      subject(:error_hash) { ErrorSerializer.new(error_response).to_hash }

      let(:error_response) do
        {
          status: 400,
          messages: ['some error message',
                     'another error message',
                     'and another error message']
        }
      end

      it 'returns a JSON:API compliable error hash', :aggregate_failures do
        expect(error_hash).to be_a(Hash)

        expect(error_hash).to have_key(:errors)
        expect(error_hash[:errors]).to be_an(Array)
        expect(error_hash[:errors].size).to eq(3)

        error_hash[:errors].each do |error|
          expect(error[:status]).to eq(error_response[:status].to_s)
        end

        expect(error_hash[:errors].first).to be_a(Hash)

        expect(error_hash[:errors].first).to have_key(:status)
        expect(error_hash[:errors].first[:status]).to be_a(String)

        expect(error_hash[:errors].first).to have_key(:detail)
        expect(error_hash[:errors].first[:detail]).to be_a(String)
      end
    end
  end
end
