require 'rails_helper'

describe BookCollection, type: :poro do
  describe 'object creation' do
    subject(:book_collection) { BookCollection.new(books, forecast) }

    # See spec/support/books_response_body.rb for #books_response_body
    let(:books) { books_response_body }
    # See spec/support/forecast_response_body.rb for #forecast_imperial_response_body
    let(:forecast) { forecast_imperial_response_body }

    it 'is valid and has readable attributes' do
      expect(book_collection).to be_a(BookCollection)

      expect(book_collection.id).to be_nil

      expect(book_collection.destination).to be_a(String)
      expect(book_collection.destination).to eq('denver,co')

      expect(book_collection.forecast).to be_a(Hash)
      expect(book_collection.forecast.size).to eq(2)

      expect(book_collection.forecast).to have_key(:summary)
      expect(book_collection.forecast[:summary]).to be_a(String)
      expect(book_collection.forecast[:summary]).to eq('clear sky')

      expect(book_collection.forecast).to have_key(:temperature)
      expect(book_collection.forecast[:temperature]).to be_a(String)
      expect(book_collection.forecast[:temperature]).to eq('57 F')

      expect(book_collection.total_books_found).to be_an(Integer)
      expect(book_collection.total_books_found).to eq(35990)

      expect(book_collection.books).to be_an(Array)
      expect(book_collection.books.size).to eq(5)

      book_collection.books.each do |book|
        expect(book).to be_a(Hash)
        expect(book.size).to eq(3)

        expect(book).to have_key(:isbn)
        expect(book[:isbn]).to be_an(Array)

        book[:isbn].each do |isbn|
          expect(isbn).to be_a(String)
        end

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

  describe 'instance methods' do
    describe '#populate_forecast' do
      context 'when I provide a forecast' do
        subject(:book_collection) { BookCollection.new(books, forecast) }

        # See spec/support/books_response_body.rb for #books_response_body
        let(:books) { books_response_body }
        # See spec/support/forecast_response_body.rb for #forecast_imperial_response_body
        let(:forecast) { forecast_imperial_response_body }

        it 'returns the forecast as a hash' do
          expected = {
            summary: 'clear sky',
            temperature: '57 F'
          }
          expect(book_collection.populate_forecast(forecast)).to eq(expected)
        end
      end
    end
  end
end
