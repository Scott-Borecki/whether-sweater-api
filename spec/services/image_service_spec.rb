require 'rails_helper'

describe ImageService, type: :service do
  describe 'class methods' do
    describe '.get_background_image' do
      context 'when I provide valid coordinates', :vcr do
        subject(:image_data) { ImageService.get_background_image(location) }

        let(:location) { { location: 'denver,co' } }

        it 'returns the image data as a hash', :aggregate_failures do
          expect(image_data).to be_a(Hash)

          expect(image_data).to have_key(:location)
          expect(image_data[:location]).to be_a(Hash)

          expect(image_data[:location]).to have_key(:name)
          expect(image_data[:location][:name]).to be_a(String)

          expect(image_data).to have_key(:urls)
          expect(image_data[:urls]).to be_a(Hash)

          expect(image_data[:urls]).to have_key(:full)
          expect(image_data[:urls][:full]).to be_a(String)

          expect(image_data).to have_key(:user)
          expect(image_data[:user]).to be_a(Hash)

          expect(image_data[:user]).to have_key(:username)
          expect(image_data[:user][:username]).to be_a(String)

          expect(image_data[:user]).to have_key(:links)
          expect(image_data[:user][:links]).to be_a(Hash)

          expect(image_data[:user][:links]).to have_key(:html)
          expect(image_data[:user][:links][:html]).to be_a(String)
        end
      end
      #
      # TODO: Add sad path testing.  Right now it returns a random photo.
      #       Perhaps the query validation is performed in the controller.
      # context 'when I do not provide a location', :vcr do
      #   subject(:response) { ImageService.get_background_image(empty_params) }
      #
      #   let(:empty_params) { { location: '' } }
      #
      #   it 'returns the error details as a hash', :aggregate_failures do
      #     expect(response).to be_a(Hash)
      #     require "pry"; binding.pry
      #     expect(response[:cod]).to eq('400')
      #     expect(response[:message]).to eq('Nothing to geocode')
      #   end
      # end
    end
  end
end
