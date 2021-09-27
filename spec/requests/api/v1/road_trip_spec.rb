require 'rails_helper'

# See spec/support/shared_examples/requests/ for shared examples
# See spec/support/helpers/requests/request_spec_helper.rb for #json helper method
describe 'Api::V1::RoadTrips API', type: :request do
  describe 'GET /api/v1/road_trip', :vcr do
    context 'when I provide a valid API key' do
      context 'when I provide road trip parameters' do
        let!(:user) { create(:user) }
        let(:api_key) { user.api_key }
        let(:road_trip_parameters) do
          {
            origin: 'Denver,CO',
            destination: 'Pueblo,CO',
            api_key: api_key
          }
        end

        before { get '/api/v1/road_trip', params: road_trip_parameters }

        it 'returns the road trip details' do
          expect(json[:data][:id]).to be_nil
          expect(json[:data][:type]).to eq('roadtrip')
          expect(json[:data][:attributes].size).to eq(4)
          expect(json[:data][:attributes][:start_city]).to eq('Denver, CO')
          expect(json[:data][:attributes][:end_city]).to eq('Pueblo, CO')
          expect(json[:data][:attributes][:travel_time]).to be_a(String)
          expect(json[:data][:attributes][:weather_at_eta]).to be_a(Hash)
          expect(json[:data][:attributes][:weather_at_eta].size).to eq(2)
          expect(json[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Numeric)
          expect(json[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
        end

        include_examples 'compliant json data format'
        include_examples 'status code 200'
      end

      context 'when I provide an impossible route' do
        let!(:user) { create(:user) }
        let(:api_key) { user.api_key }
        let(:road_trip_parameters) do
          {
            origin: 'Denver,CO',
            destination: 'London,UK',
            api_key: api_key
          }
        end

        before { get '/api/v1/road_trip', params: road_trip_parameters }

        it 'returns the road trip details' do
          expect(json[:data][:id]).to be_nil
          expect(json[:data][:type]).to eq('roadtrip')
          expect(json[:data][:attributes].size).to eq(4)
          expect(json[:data][:attributes][:start_city]).to eq('Denver, CO')
          expect(json[:data][:attributes][:end_city]).to eq('London, UK')
          expect(json[:data][:attributes][:travel_time]).to eq('impossible')
          expect(json[:data][:attributes][:weather_at_eta]).to be_a(Hash)
          expect(json[:data][:attributes][:weather_at_eta]).to be_empty
        end

        include_examples 'compliant json data format'
        include_examples 'status code 200'
      end

      context 'when I do not provide an origin' do
        let!(:user) { create(:user) }
        let(:api_key) { user.api_key }
        let(:road_trip_parameters) do
          {
            destination: 'Pueblo,CO',
            api_key: api_key
          }
        end

        before { get '/api/v1/road_trip', params: road_trip_parameters }

        it 'returns a helpful error message' do
          expect(json[:errors].size).to eq(1)
          expect(json[:errors].first[:detail]).to eq("Location can't be blank")
        end

        include_examples 'compliant json error format'
        include_examples 'status code 400'
      end

      context 'when I do not provide an destination' do
        let!(:user) { create(:user) }
        let(:api_key) { user.api_key }
        let(:road_trip_parameters) do
          {
            origin: 'Denver,CO',
            api_key: api_key
          }
        end

        before { get '/api/v1/road_trip', params: road_trip_parameters }

        it 'returns a helpful error message' do
          expect(json[:errors].size).to eq(1)
          expect(json[:errors].first[:detail]).to eq("Location can't be blank")
        end

        include_examples 'compliant json error format'
        include_examples 'status code 400'
      end
    end
  end

  context 'when I do not provide a valid API key' do
    let(:bad_api_key) { SecureRandom.hex }
    let(:road_trip_parameters) do
      {
        origin: 'Denver,CO',
        destination: 'Pueblo,CO',
        api_key: bad_api_key
      }
    end

    before { get '/api/v1/road_trip', params: road_trip_parameters }

    it 'returns a helpful error message' do
      expect(json[:errors].size).to eq(1)
      expect(json[:errors].first[:detail]).to eq('You have entered an invalid API key')
    end

    include_examples 'compliant json error format'
    include_examples 'status code 403'
  end
end
