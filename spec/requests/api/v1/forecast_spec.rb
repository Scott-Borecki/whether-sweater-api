require 'rails_helper'

describe 'Api::V1::Forecast API', type: :request do
  describe 'GET /api/v1/forecast', :vcr do
    context 'when I do not provide parameters' do
      before { get '/api/v1/forecast' }

      it 'returns a bad request error message' do
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json).to have_key(:errors)
        expect(json[:errors]).to be_an(Array)
        expect(json[:errors].size).to eq(1)
        expect(json[:errors].first).to be_a(Hash)
        expect(json[:errors].first.size).to eq(2)
        expect(json[:errors].first).to have_key(:status)
        expect(json[:errors].first[:status]).to eq('400')
        expect(json[:errors].first).to have_key(:detail)
        expect(json[:errors].first[:detail]).to eq('Illegal argument from request: Insufficient info for location')
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when I provide location parameters' do
      let(:location) { 'denver,co' }

      before { get '/api/v1/forecast', params: { location: location } }

      it 'returns the forecast for the given location' do
        expect(JSON.parse(response.body)).to be_a(Hash)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
