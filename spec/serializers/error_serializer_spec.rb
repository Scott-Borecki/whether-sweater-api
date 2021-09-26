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
      context 'when a standard status code is provided' do
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

          expect(error_hash[:errors].first).to have_key(:title)
          expect(error_hash[:errors].first[:title]).to be_a(String)

          expect(error_hash[:errors].first).to have_key(:detail)
          expect(error_hash[:errors].first[:detail]).to be_a(String)
        end
      end

      context 'when a standard status code is not provided' do
        subject(:error_hash) { ErrorSerializer.new(error_response).to_hash }

        let(:error_response) do
          {
            status: 499,
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

          expect(error_hash[:errors].first).not_to have_key(:title)

          expect(error_hash[:errors].first).to have_key(:detail)
          expect(error_hash[:errors].first[:detail]).to be_a(String)
        end
      end
    end

    describe '#title' do
      context 'when a standard HTTP status code is provided' do
        it 'returns the HTTP code status title' do
          error_response_400 = {
            status: 400,
            messages: ['some error message',
                       'another error message',
                       'and another error message']
          }
          error_serializer = ErrorSerializer.new(error_response_400)

          expect(error_serializer.title).to eq('Bad Request')

          error_response_404 = {
            status: 404,
            messages: ['some error message',
                       'another error message',
                       'and another error message']
          }
          error_serializer = ErrorSerializer.new(error_response_404)

          expect(error_serializer.title).to eq('Not Found')

          error_response_422 = {
            status: 422,
            messages: ['some error message',
                       'another error message',
                       'and another error message']
          }
          error_serializer = ErrorSerializer.new(error_response_422)

          expect(error_serializer.title).to eq('Unprocessable Entity')
        end
      end

      context 'when a standard HTTP status code is not provided' do
        it 'returns nil' do
          error_response_499 = {
            status: 499,
            messages: ['some error message',
                       'another error message',
                       'and another error message']
          }
          error_serializer = ErrorSerializer.new(error_response_499)

          expect(error_serializer.title).to be_nil
        end
      end
    end
  end
end
