require 'rails_helper'

describe BookSearchFacade, type: :facade do
  describe 'class methods' do
    describe '.get_books_based_on_location', :vcr do
      context 'when I provide valid parameters' do
        subject(:book_collection) { BookSearchFacade.get_books_based_on_location(search_params) }

        let(:location) { 'denver,co' }
        let(:quantity) { 5 }
        let(:search_params) { { location: location, quantity: quantity } }

        it 'returns a BookCollection object' do
          expect(book_collection).to be_an_instance_of(BookCollection)
        end
      end
    end
  end
end
