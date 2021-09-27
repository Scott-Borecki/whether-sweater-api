require 'rails_helper'

describe RoadTripSerializer, type: :serializer do
  describe 'object creation' do
    subject(:road_trip_serializer) { RoadTripSerializer.new(road_trip) }

    # See spec/support/directions_response_body.rb for #directions_response_body
    let(:directions) { directions_response_body }
    # See spec/support/forecast_imperial_response_body.rb for #forecast_imperial_response_body
    let(:forecast) { forecast_imperial_response_body }
    let(:road_trip) { RoadTrip.new(directions, forecast) }

    it 'is valid and has readable attributes', :aggregate_failures do
      expect(road_trip_serializer).to be_a(RoadTripSerializer)
    end
  end

  describe 'instance methods' do
    describe '#serializable_hash' do
      subject(:road_trip_hash) { RoadTripSerializer.new(road_trip).serializable_hash }

      # See spec/support/directions_response_body.rb for #directions_response_body
      let(:directions) { directions_response_body }
      # See spec/support/forecast_imperial_response_body.rb for #forecast_imperial_response_body
      let(:forecast) { forecast_imperial_response_body }
      let(:road_trip) { RoadTrip.new(directions, forecast) }

      it 'returns a JSON:API compliable hash', :aggregate_failures do
        expect(road_trip_hash).to be_a(Hash)

        expect(road_trip_hash).to have_key(:data)
        expect(road_trip_hash[:data]).to be_a(Hash)
        expect(road_trip_hash[:data].size).to eq(3)

        expect(road_trip_hash[:data]).to have_key(:id)
        expect(road_trip_hash[:data][:id]).to be_nil

        expect(road_trip_hash[:data]).to have_key(:type)
        expect(road_trip_hash[:data][:type]).to eq(:roadtrip)

        expect(road_trip_hash[:data]).to have_key(:attributes)
        expect(road_trip_hash[:data][:attributes]).to be_a(Hash)
        expect(road_trip_hash[:data][:attributes].size).to eq(4)

        expect(road_trip_hash[:data][:attributes]).to have_key(:start_city)
        expect(road_trip_hash[:data][:attributes][:start_city]).to be_a(String)

        expect(road_trip_hash[:data][:attributes]).to have_key(:end_city)
        expect(road_trip_hash[:data][:attributes][:end_city]).to be_a(String)

        expect(road_trip_hash[:data][:attributes]).to have_key(:travel_time)
        expect(road_trip_hash[:data][:attributes][:travel_time]).to be_a(String)

        expect(road_trip_hash[:data][:attributes]).to have_key(:weather_at_eta)
        expect(road_trip_hash[:data][:attributes][:weather_at_eta]).to be_a(Hash)
        expect(road_trip_hash[:data][:attributes][:weather_at_eta].size).to eq(2)

        expect(road_trip_hash[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(road_trip_hash[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Numeric)

        expect(road_trip_hash[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
        expect(road_trip_hash[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
      end
    end
  end
end
