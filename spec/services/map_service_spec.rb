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
      context 'when I provide locations with a possible route', :vcr do
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

          expect(directions).to have_key(:info)
          expect(directions[:info]).to be_a(Hash)

          expect(directions[:info]).to have_key(:statuscode)
          expect(directions[:info][:statuscode]).to be_an(Integer)
          expect(directions[:info][:statuscode]).to eq(0)
        end
      end

      context 'when I provide locations with an impossible route', :vcr do
        subject(:response) { MapService.get_directions(impossible_route_params) }

        let(:impossible_route_params) do
          {
            origin: "Denver,CO",
            destination: "London,UK"
          }
        end

        it 'returns the error details as a hash', :aggregate_failures do
          expect(response).to be_a(Hash)

          expect(response).to have_key(:route)
          expect(response[:route]).to be_a(Hash)
          expect(response[:route].size).to eq(1)

          expect(response[:route]).to have_key(:routeError)
          expect(response[:route][:routeError]).to be_a(Hash)
          expect(response[:route][:routeError].size).to eq(2)

          expect(response).to have_key(:info)
          expect(response[:info]).to be_a(Hash)

          expect(response[:info]).to have_key(:statuscode)
          expect(response[:info][:statuscode]).to be_an(Integer)
          expect(response[:info][:statuscode]).to eq(402)

          expect(response[:info]).to have_key(:messages)
          expect(response[:info][:messages]).to be_an(Array)
          expect(response[:info][:messages]).to all(be_a(String))
          expect(response[:info][:messages].first).to eq('We are unable to route with the given locations.')
        end
      end
    end
  end
end
