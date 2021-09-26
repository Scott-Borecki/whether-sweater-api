require 'rails_helper'

describe Image, type: :poro do
  describe 'object creation' do
    it 'is valid and has readable attributes' do
      # See spec/support/image_response_body.rb for #image_response_body
      data  = image_response_body
      image = Image.new(data)

      expect(image).to be_a(Image)

      expect(image.image).to be_a(Hash)
      expect(image.image.size).to eq(3)

      expect(image.image).to have_key(:location)
      expect(image.image[:location]).to be_a(String)

      expect(image.image).to have_key(:image_url)
      expect(image.image[:image_url]).to be_a(String)

      expect(image.image).to have_key(:credit)
      expect(image.image[:credit]).to be_a(Hash)
      expect(image.image[:credit].size).to eq(2)

      expect(image.image[:credit]).to have_key(:source)
      expect(image.image[:credit][:source]).to be_a(String)

      expect(image.image[:credit]).to have_key(:author)
      expect(image.image[:credit][:author]).to be_a(String)
    end
  end
end
