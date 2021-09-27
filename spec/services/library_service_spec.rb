require 'rails_helper'

describe LibraryService, type: :service do
  describe 'class methods' do
    describe '.get_books_based_on_location' do
      context 'when I provide a valid location', :vcr do
        subject(:book_data) { LibraryService.get_books_based_on_location(search_params) }

        let(:location) { 'denver,co' }
        let(:quantity) { 5 }
        let(:search_params) { { location: location, quantity: quantity } }

        it 'returns the book data as a hash', :aggregate_failures do
          expect(book_data).to be_a(Hash)

          expect(book_data).to have_key(:numFound)
          expect(book_data[:numFound]).to be_an(Integer)

          expect(book_data).to have_key(:q)
          expect(book_data[:q]).to be_a(String)
          expect(book_data[:q]).to eq(location.tr(',', '+'))

          expect(book_data).to have_key(:docs)
          expect(book_data[:docs]).to be_an(Array)
          expect(book_data[:docs].size).to eq(quantity)

          book_data[:docs].each do |book|
            expect(book).to have_key(:isbn)
            expect(book[:isbn]).to be_an(Array)

            expect(book).to have_key(:title)
            expect(book[:title]).to be_a(String)

            expect(book).to have_key(:publisher)
            expect(book[:publisher]).to be_an(Array)

            book[:publisher].each do |publisher|
              expect(publisher).to be_a(String)
            end
          end
        end
      end
    end
  end
end
