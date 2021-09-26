require 'rails_helper'

# See spec/support/shared_examples/requests/ for shared examples
# See spec/support/helpers/requests/request_spec_helper.rb for #json helper method
describe 'Api::V1::Forecast API', type: :request do
  describe 'GET /api/v1/forecast', :vcr do
    context 'when I provide location parameters' do
      let(:location) { 'denver,co' }

      before { get '/api/v1/forecast', params: { location: location } }

      it 'returns the forecast for the given location' do
        expect(json[:data][:attributes][:current_weather].size).to eq(10)
        expect(json[:data][:attributes][:daily_weather].size).to eq(8)
        expect(json[:data][:attributes][:daily_weather].first.size).to eq(7)
        expect(json[:data][:attributes][:hourly_weather].size).to eq(48)
        expect(json[:data][:attributes][:hourly_weather].first.size).to eq(4)
      end

      include_examples 'compliant json data format'
      include_examples 'status code 200'
    end

    context 'when I do not provide parameters' do
      before { get '/api/v1/forecast' }

      it 'returns a bad request error message' do
        expect(json[:errors].size).to eq(1)
        expect(json[:errors].first[:detail]).to eq("Location can't be blank")
      end

      include_examples 'compliant json error format'
      include_examples 'status code 400'
    end
  end
end
