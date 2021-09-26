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
    #
    # TODO: Add sad path testing.  Right now it returns a random photo.
    #       Perhaps the query validation is performed in the controller.
    # context 'when I do not provide parameters' do
    #   before { get '/api/v1/backgrounds' }
    #
    #   it 'returns a bad request error message' do
    #     json = JSON.parse(response.body, symbolize_names: true)
    #
    #     require "pry"; binding.pry
    #
    #     expect(json).to be_a(Hash)
    #     expect(json).to have_key(:errors)
    #     expect(json[:errors]).to be_an(Array)
    #     expect(json[:errors].size).to eq(1)
    #   end
    #
    #   it 'returns status code 400' do
    #     expect(response).to have_http_status(:bad_request)
    #   end
    # end
  end
end
