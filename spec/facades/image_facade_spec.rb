require 'rails_helper'

describe ImageFacade, type: :facade do
  describe 'class methods' do
    describe '.get_background_image', :vcr do
      context 'when I provide a valid location' do
        subject(:image) { ImageFacade.get_background_image(location: location) }

        let(:location) { 'denver,co' }

        it 'returns an Image object' do
          expect(image).to be_an_instance_of(Image)
        end
      end
      #
      # TODO: Add sad path testing.  Right now it returns a random photo.
      #       Perhaps the query validation is performed in the controller.
      # context 'when I do not provide a location' do
      #   subject(:error_serializer) { ImageFacade.get_background_image('') }
      #
      #   it 'returns an ErrorSerializer object' do
      #     expect(error_serializer).to be_an_instance_of(ErrorSerializer)
      #     expect(error_serializer.status).to be_an(Integer)
      #     expect(error_serializer.messages).to be_an(Array)
      #   end
      # end
    end
  end
end
