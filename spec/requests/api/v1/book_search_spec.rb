require 'rails_helper'

RSpec.describe "Api::V1::BookSearches", type: :request do
  describe "GET /api/v1/book-search" do
    context 'when I provide valid parameters' do
      let(:location) { 'denver,co' }
      let(:quantity) { 5 }
      let(:search_params) { { location: location, quantity: quantity } }

      before { get '/api/v1/book-search', params: search_params }

      it 'returns books based on a provided destination city' do
        expect(json[:data][:type]).to eq('books')
        expect(json[:data][:attributes][:image][:destination]).to eq(location)
        expect(json[:data][:attributes][:image][:books].size).to eq(5)
      end

      include_examples 'compliant json data format'
      include_examples 'status code 200'
    end
    #
    # context 'when I do not provide parameters' do
    #   before { get '/api/v1/book-search' }
    #
    #   it 'returns a bad request error message' do
    #     expect(json[:errors].size).to eq(1)
    #     expect(json[:errors].first[:detail]).to eq("Location can't be blank")
    #   end
    #
    #   include_examples 'compliant json error format'
    #   include_examples 'status code 400'
    # end
  end
end
