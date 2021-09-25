require 'rails_helper'

describe LocationService, type: :service do
  describe 'class methods' do
    describe '.get_coordinates' do
      context 'when I provide a location', :vcr do
        subject(:coordinates) { LocationService.get_coordinates(location) }

        let(:location) { 'denver,co' }

        it 'returns the location details as a hash', :aggregate_failures do
          expect(coordinates).to be_a(Hash)
          expect(coordinates[:results].first[:providedLocation][:location]).to eq(location)
          expect(coordinates[:results].first[:locations].first[:displayLatLng][:lat]).to be_a(Float)
          expect(coordinates[:results].first[:locations].first[:displayLatLng][:lng]).to be_a(Float)
        end
      end

      context 'when I do not provide a location', :vcr do
        subject(:response) { LocationService.get_coordinates(empty_location) }

        let(:empty_location) { '' }

        it 'returns the error details as a hash', :aggregate_failures do
          expect(response).to be_a(Hash)
          expect(response[:results].first[:providedLocation][:location]).to eq(empty_location)
          expect(response[:info][:statuscode]).to eq(400)
          expect(response[:info][:messages]).to eq(['Illegal argument from request: Insufficient info for location'])
        end
      end
    end
  end
end
