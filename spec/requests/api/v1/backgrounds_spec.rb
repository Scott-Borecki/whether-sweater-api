require 'rails_helper'

# See spec/support/shared_examples/requests/ for shared examples
# See spec/support/helpers/requests/request_spec_helper.rb for #json helper method
describe 'Api::V1::Backgrounds', type: :request do
  describe 'GET /api/v1/backgrounds', :vcr do
    context 'when I provide location parameters' do
      let(:location) { 'denver,co' }

      before { get '/api/v1/backgrounds', params: { location: location } }

      it 'returns an image for the given location' do
        expect(json[:data][:type]).to eq('image')
        expect(json[:data][:attributes][:image][:location]).to be_a(String)
        expect(json[:data][:attributes][:image][:image_url]).to be_a(String)
        expect(json[:data][:attributes][:image][:credit][:source]).to be_a(String)
        expect(json[:data][:attributes][:image][:credit][:author]).to be_a(String)
      end

      include_examples 'compliant json data format'
      include_examples 'status code 200'
    end

    context 'when I do not provide parameters' do
      before { get '/api/v1/backgrounds' }

      it 'returns a bad request error message' do
        expect(json[:errors].size).to eq(1)
        expect(json[:errors].first[:detail]).to eq("Location can't be blank")
      end

      include_examples 'compliant json error format'
      include_examples 'status code 400'
    end
  end
end
