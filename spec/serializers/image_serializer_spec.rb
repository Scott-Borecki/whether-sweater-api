require 'rails_helper'

describe ImageSerializer, type: :serializer do
  describe 'object creation' do
    subject(:image_serializer) { ImageSerializer.new(image) }

    # See spec/support/image_response_body.rb for test setup helper method:
    #   #image_response_body
    let(:image) { Image.new(image_response_body) }

    it 'is valid and has readable attributes', :aggregate_failures do
      expect(image_serializer).to be_a(ImageSerializer)
    end
  end

  describe 'instance methods' do
    describe '#serializable_hash' do
      subject(:image_hash) { ImageSerializer.new(image).serializable_hash }

      # See spec/support/image_response_body.rb for test setup helper method:
      #   #image_response_body
      let(:image) { Image.new(image_response_body) }

      it 'returns a JSON:API compliable hash', :aggregate_failures do
        expect(image_hash).to be_a(Hash)

        expect(image_hash).to have_key(:data)
        expect(image_hash[:data]).to be_a(Hash)
        expect(image_hash[:data].size).to eq(3)

        expect(image_hash[:data]).to have_key(:id)
        expect(image_hash[:data][:id]).to be_nil

        expect(image_hash[:data]).to have_key(:type)
        expect(image_hash[:data][:type]).to eq(:image)

        expect(image_hash[:data]).to have_key(:attributes)
        expect(image_hash[:data][:attributes]).to be_a(Hash)
        expect(image_hash[:data][:attributes].size).to eq(1)
      end
    end
  end
end
