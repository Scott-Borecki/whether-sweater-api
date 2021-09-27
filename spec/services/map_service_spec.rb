require 'rails_helper'

describe MapService, type: :service do
  describe 'class methods' do
    describe '.get_coordinates' do
      context 'when I provide a location', :vcr do
        subject(:coordinates) { MapService.get_coordinates(location) }

        let(:location) { 'denver,co' }

        it 'returns the location details as a hash', :aggregate_failures do
          expect(coordinates).to be_a(Hash)
          expect(coordinates[:results].first[:providedLocation][:location]).to eq(location)
          expect(coordinates[:results].first[:locations].first[:displayLatLng][:lat]).to be_a(Float)
          expect(coordinates[:results].first[:locations].first[:displayLatLng][:lng]).to be_a(Float)
        end
      end

      context 'when I do not provide a location', :vcr do
        subject(:response) { MapService.get_coordinates(empty_location) }

        let(:empty_location) { '' }

        it 'returns the error details as a hash', :aggregate_failures do
          expect(response).to be_a(Hash)
          expect(response[:results].first[:providedLocation][:location]).to eq(empty_location)
          expect(response[:info][:statuscode]).to eq(400)
          expect(response[:info][:messages]).to eq(['Illegal argument from request: Insufficient info for location'])
        end
      end
    end

    describe '.get_directions' do
      context 'when I provide a valid origin and destination', :vcr do
        subject(:directions) { MapService.get_directions(road_trip_parameters) }

        let(:origin_city) { 'Denver'}
        let(:origin_state) { 'CO'}
        let(:destination_city) { 'Pueblo'}
        let(:destination_state) { 'CO'}
        let(:road_trip_parameters) do
          {
            origin: "#{origin_city},#{origin_state}",
            destination: "#{destination_city},#{destination_state}"
          }
        end

        it 'returns the location details as a hash', :aggregate_failures do
          expect(directions).to be_a(Hash)

          expect(directions).to have_key(:route)
          expect(directions[:route]).to be_a(Hash)

          expect(directions[:route]).to have_key(:locations)
          expect(directions[:route][:locations]).to be_an(Array)
          expect(directions[:route][:locations].size).to eq(2)

          directions[:route][:locations].each do |location|
            expect(location).to be_a(Hash)

            expect(location).to have_key(:adminArea5)
            expect(location[:adminArea5]).to be_a(String)

            expect(location).to have_key(:adminArea3)
            expect(location[:adminArea3]).to be_a(String)
          end

          expect(directions[:route][:locations].first[:adminArea5]).to eq(origin_city)
          expect(directions[:route][:locations].first[:adminArea3]).to eq(origin_state)
          expect(directions[:route][:locations].last[:adminArea5]).to eq(destination_city)
          expect(directions[:route][:locations].last[:adminArea3]).to eq(destination_state)

          expect(directions[:route]).to have_key(:realTime)
          expect(directions[:route][:realTime]).to be_an(Integer)

          expect(directions[:route]).to have_key(:time)
          expect(directions[:route][:time]).to be_an(Integer)
        end
      end

      context 'when I do not provide a valid origin and destination', :vcr do
        subject(:response) { MapService.get_directions(empty_location) }

        let(:empty_location) { '' }

        xit 'returns the error details as a hash', :aggregate_failures do
          require "pry"; binding.pry
          expect(response).to be_a(Hash)
          expect(response[:results].first[:providedLocation][:location]).to eq(empty_location)
          expect(response[:info][:statuscode]).to eq(400)
          expect(response[:info][:messages]).to eq(['Illegal argument from request: Insufficient info for location'])
        end
      end
    end
  end
end
