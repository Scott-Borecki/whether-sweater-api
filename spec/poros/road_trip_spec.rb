require 'rails_helper'

describe RoadTrip, type: :poro do
  describe 'object creation' do
    context 'when the route is possible' do
      xit 'is valid and has readable attributes' do
        # See spec/support/road_trip_response_body.rb for #road_trip_response_body
        data  = road_trip_response_body
        road_trip = RoadTrip.new(data)

        expect(road_trip).to be_a(RoadTrip)

        expect(road_trip.start_city).to be_a(String)
        expect(road_trip.start_city).to eq('Denver, CO')

        expect(road_trip.end_city).to be_a(String)
        expect(road_trip.end_city).to eq('Estes Park, CO')

        expect(road_trip.travel_time).to be_a(String)
        expect(road_trip.travel_time).to eq('2 hours, 13 minutes')

        expect(road_trip.weather_at_eta).to be_a(Hash)
        expect(road_trip.weather_at_eta.size).to eq(2)

        expect(road_trip.weather_at_eta).to have_key(:temperature)
        expect(road_trip.weather_at_eta[:temperature]).to be_a(Numeric)
        expect(road_trip.weather_at_eta[:temperature]).to eq(59.4)

        expect(road_trip.weather_at_eta).to have_key(:conditions)
        expect(road_trip.weather_at_eta[:conditions]).to be_a(String)
        expect(road_trip.weather_at_eta[:conditions]).to eq('partly cloudy with a chance of meatballs')
      end
    end

    context 'when the route is impossible' do
      xit 'is valid and has readable attributes' do
        # See spec/support/road_trip_response_body.rb for #road_trip_response_body
        data  = road_trip_response_body
        road_trip = RoadTrip.new(data)

        expect(road_trip).to be_a(RoadTrip)

        expect(road_trip.start_city).to be_a(String)
        expect(road_trip.start_city).to eq('Denver, CO')

        expect(road_trip.end_city).to be_a(String)
        expect(road_trip.end_city).to eq('London, UK')

        expect(road_trip.travel_time).to be_a(String)
        expect(road_trip.travel_time).to eq('impossible route')

        expect(road_trip.weather_at_eta).to be_a(Hash)
        expect(road_trip.weather_at_eta.size).to eq(0)
      end
    end
  end
end
