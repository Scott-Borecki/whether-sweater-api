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
    end
  end
end
