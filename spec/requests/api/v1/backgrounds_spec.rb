require 'rails_helper'

describe 'Api::V1::Backgrounds', type: :request do
  describe 'GET /api/v1/backgrounds', :vcr do
    context 'when I provide location parameters' do
      let(:location) { 'denver,co' }

      before { get '/api/v1/backgrounds', params: { location: location } }

      it 'returns an image for the given location' do
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:data][:type]).to eq('image')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when I do not provide parameters' do
      before { get '/api/v1/backgrounds' }

      it 'returns a bad request error message' do
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json).to have_key(:errors)
        expect(json[:errors]).to be_a(Array)
        expect(json[:errors].size).to eq(1)
        expect(json[:errors].first).to be_a(Hash)
        expect(json[:errors].first.size).to eq(3)
        expect(json[:errors].first[:status]).to eq(400)
        expect(json[:errors].first[:title]).to eq('Bad Request')
        expect(json[:errors].first[:detail]).to eq("Location can't be blank")
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
