require 'rails_helper'

RSpec.describe "Api::V1::BookSearches", type: :request do
  describe "GET /api/v1/book-search", :vcr do
    context 'when I provide valid parameters' do
      let(:location) { 'denver,co' }
      let(:quantity) { 5 }
      let(:search_params) { { location: location, quantity: quantity } }

      before { get '/api/v1/book-search', params: search_params }

      it 'returns books based on a provided destination city' do
        expect(json[:data][:type]).to eq('books')
        expect(json[:data][:attributes].size).to eq(4)
        expect(json[:data][:attributes][:destination]).to eq(location)
        expect(json[:data][:attributes][:books].size).to eq(quantity)
      end

      include_examples 'compliant json data format'
      include_examples 'status code 200'
    end

    context 'when I do not provide valid parameters' do
      context 'when I do not provide a valid location' do
        let(:quantity) { 5 }
        let(:invalid_search_params) { { quantity: quantity } }

        before { get '/api/v1/book-search', params: invalid_search_params }

        it 'returns a bad request error message' do
          expect(json[:errors].size).to eq(1)
          expect(json[:errors].first[:detail]).to eq("Location can't be blank")
        end

        include_examples 'compliant json error format'
        include_examples 'status code 400'
      end
    end
  end
end
