require 'rails_helper'

describe MapFacade, type: :facade do
  describe 'class methods' do
    describe '.get_coordinates', :vcr do
      context 'when I provide a valid location' do
        subject(:coordinates) { MapFacade.get_coordinates(location) }

        let(:location) { 'denver,co' }

        it 'returns a Location object' do
          expect(coordinates).to be_an_instance_of(Location)
        end
      end

      context 'when I do not provide a location' do
        subject(:error_serializer) { MapFacade.get_coordinates('') }

        it 'returns an ErrorSerializer object' do
          expect(error_serializer).to be_an_instance_of(ErrorSerializer)
          expect(error_serializer.status).to be_an(Integer)
          expect(error_serializer.messages).to be_an(Array)
        end
      end
    end

    describe '.get_directions', :vcr do
      context 'when I provide a valid parameters' do
        subject(:road_trip) { MapFacade.get_directions(parameters) }

        let(:parameters) do
          {
            origin: 'Denver,CO',
            destination: 'Pueblo,CO'
          }
        end

        xit 'returns a RoadTrip object' do
          expect(road_trip).to be_an_instance_of(RoadTrip)
        end
      end
      #
      # context 'when I do not provide a location' do
      #   subject(:error_serializer) { MapFacade.get_coordinates('') }
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
