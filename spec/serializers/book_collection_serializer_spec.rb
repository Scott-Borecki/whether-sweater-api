require 'rails_helper'

describe BookCollectionSerializer, type: :serializer do
  describe 'object creation' do
    subject(:book_collection_serializer) { BookCollectionSerializer.new(book_collection) }

    # See spec/support/books_response_body.rb for #books_response_body
    let(:books) { books_response_body }
    # See spec/support/forecast_response_body.rb for #forecast_imperial_response_body
    let(:forecast) { forecast_imperial_response_body }
    let(:book_collection) { BookCollection.new(books, forecast) }

    it 'is valid and has readable attributes', :aggregate_failures do
      expect(book_collection_serializer).to be_a(BookCollectionSerializer)
    end
  end

  describe 'instance methods' do
    describe '#serializable_hash' do
      subject(:book_collection_hash) { BookCollectionSerializer.new(book_collection).serializable_hash }

      # See spec/support/books_response_body.rb for #books_response_body
      let(:books) { books_response_body }
      # See spec/support/forecast_response_body.rb for #forecast_imperial_response_body
      let(:forecast) { forecast_imperial_response_body }
      let(:book_collection) { BookCollection.new(books, forecast) }

      it 'returns a JSON:API compliable hash', :aggregate_failures do
        expect(book_collection_hash).to be_a(Hash)

        expect(book_collection_hash).to have_key(:data)
        expect(book_collection_hash[:data]).to be_a(Hash)
        expect(book_collection_hash[:data].size).to eq(3)

        expect(book_collection_hash[:data]).to have_key(:id)
        expect(book_collection_hash[:data][:id]).to be_nil

        expect(book_collection_hash[:data]).to have_key(:type)
        expect(book_collection_hash[:data][:type]).to eq(:books)

        expect(book_collection_hash[:data]).to have_key(:attributes)
        expect(book_collection_hash[:data][:attributes]).to be_a(Hash)
        expect(book_collection_hash[:data][:attributes].size).to eq(4)

        expect(book_collection_hash[:data][:attributes]).to have_key(:destination)
        expect(book_collection_hash[:data][:attributes][:destination]).to be_a(String)

        expect(book_collection_hash[:data][:attributes]).to have_key(:forecast)
        expect(book_collection_hash[:data][:attributes][:forecast]).to be_a(Hash)

        expect(book_collection_hash[:data][:attributes][:forecast]).to have_key(:summary)
        expect(book_collection_hash[:data][:attributes][:forecast][:summary]).to be_a(String)

        expect(book_collection_hash[:data][:attributes][:forecast]).to have_key(:temperature)
        expect(book_collection_hash[:data][:attributes][:forecast][:temperature]).to be_a(String)

        expect(book_collection_hash[:data][:attributes]).to have_key(:total_books_found)
        expect(book_collection_hash[:data][:attributes][:total_books_found]).to be_an(Integer)

        expect(book_collection_hash[:data][:attributes]).to have_key(:books)
        expect(book_collection_hash[:data][:attributes][:books]).to be_an(Array)
        expect(book_collection_hash[:data][:attributes][:books].size).to eq(5)

        book_collection_hash[:data][:attributes][:books].each do |book|
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
  end
end
