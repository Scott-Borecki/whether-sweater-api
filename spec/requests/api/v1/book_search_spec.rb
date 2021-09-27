require 'rails_helper'

# See spec/support/shared_examples/requests/ for shared examples
# See spec/support/helpers/requests/request_spec_helper.rb for #json helper method
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
        context 'when I do not provide a location' do
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

        context 'when I provide an empty location' do
          let(:empty_location) { '' }
          let(:quantity) { 5 }
          let(:invalid_search_params) { { location: empty_location, quantity: quantity } }

          before { get '/api/v1/book-search', params: invalid_search_params }
          
          it 'returns a bad request error message' do
            expect(json[:errors].size).to eq(1)
            expect(json[:errors].first[:detail]).to eq("Location can't be blank")
          end

          include_examples 'compliant json error format'
          include_examples 'status code 400'
        end
      end

      context 'when I do not provide a valid quantity' do
        context 'when I do not provide a quantity' do
          let(:location) { 'denver,co' }
          let(:invalid_search_params) { { location: location } }

          before { get '/api/v1/book-search', params: invalid_search_params }

          it 'returns a bad request error message' do
            expect(json[:errors].size).to eq(2)
            expect(json[:errors].first[:detail]).to eq("Quantity can't be blank")
            expect(json[:errors].second[:detail]).to eq('Quantity is not a number')
          end

          include_examples 'compliant json error format'
          include_examples 'status code 400'
        end

        context 'when I provide an empty quantity' do
          let(:location) { 'denver,co' }
          let(:invalid_search_params) { { location: location, quantity: '' } }

          before { get '/api/v1/book-search', params: invalid_search_params }

          it 'returns a bad request error message' do
            expect(json[:errors].size).to eq(2)
            expect(json[:errors].first[:detail]).to eq("Quantity can't be blank")
            expect(json[:errors].second[:detail]).to eq('Quantity is not a number')
          end

          include_examples 'compliant json error format'
          include_examples 'status code 400'
        end

        context 'when I provide a negative quantity' do
          let(:location) { 'denver,co' }
          let(:negative_quantity) { -5 }
          let(:invalid_search_params) { { location: location, quantity: negative_quantity } }

          before { get '/api/v1/book-search', params: invalid_search_params }

          it 'returns a bad request error message' do
            expect(json[:errors].size).to eq(1)
            expect(json[:errors].first[:detail]).to eq('Quantity must be greater than 0')
          end

          include_examples 'compliant json error format'
          include_examples 'status code 400'
        end

        context 'when I provide a quantity of zero' do
          let(:location) { 'denver,co' }
          let(:zero_quantity) { 0 }
          let(:invalid_search_params) { { location: location, quantity: zero_quantity } }

          before { get '/api/v1/book-search', params: invalid_search_params }

          it 'returns a bad request error message' do
            expect(json[:errors].size).to eq(1)
            expect(json[:errors].first[:detail]).to eq('Quantity must be greater than 0')
          end

          include_examples 'compliant json error format'
          include_examples 'status code 400'
        end
      end
    end
  end
end
