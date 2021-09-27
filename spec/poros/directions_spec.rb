require 'rails_helper'

describe Directions, type: :poro do
  describe 'object creation' do
    context 'when the route is possible' do
      it 'is valid and has readable attributes' do
        # See spec/support/directions_response_body.rb for #directions_response_body
        directions = directions_response_body
        directions = Directions.new(directions)

        expect(directions).to be_a(Directions)

        expect(directions.id).to be_nil

        expect(directions.start_city).to be_a(String)
        expect(directions.start_city).to eq('Denver, CO')

        expect(directions.end_city).to be_a(String)
        expect(directions.end_city).to eq('Pueblo, CO')

        expect(directions.end_latitude).to be_a(Float)
        expect(directions.end_latitude).to eq(38.265427)

        expect(directions.end_longitude).to be_a(Float)
        expect(directions.end_longitude).to eq(-104.610413)

        expect(directions.travel_time).to be_a(String)
        expect(directions.travel_time).to eq('1 hour, 51 minutes')

        expect(directions.travel_time_seconds).to be_an(Integer)
        expect(directions.travel_time_seconds).to eq(6683)
      end
    end
  end

  describe 'instance methods' do
    describe '#origin' do
      context 'when I provide valid parameters' do
        it 'returns the origin city and state formatted as "city, state"' do
          # See spec/support/directions_response_body.rb for #directions_response_body
          directions = directions_response_body
          directions = Directions.new(directions)
          city = 'Denver'
          state = 'CO'

          actual = directions.origin(city, state)
          expected = 'Denver, CO'
          expect(actual).to eq(expected)
        end
      end

      context 'when I provide invalid parameters'
    end

    describe '#destination' do
      context 'when I provide valid parameters' do
        it 'returns the destination city and state formatted as "city, state"' do
          # See spec/support/directions_response_body.rb for #directions_response_body
          directions = directions_response_body
          directions = Directions.new(directions)
          city = 'Pueblo'
          state = 'CO'

          actual = directions.destination(city, state)
          expected = 'Pueblo, CO'
          expect(actual).to eq(expected)
        end
      end

      context 'when I provide invalid parameters'
    end

    describe '#estimated_travel_time' do
      # See spec/support/directions_response_body.rb for #directions_response_body
      let(:directions) { Directions.new(directions_response_body) }

      context 'when I provide a time in seconds that is less than 1 hour' do
        it 'returns the travel formatted as "# minutes"' do
          travel_time_seconds = 2462

          actual = directions.estimated_travel_time(travel_time_seconds)
          expected = '41 minutes'
          expect(actual).to eq(expected)
        end
      end

      context 'when I provide a time in seconds that is less than 2 hours' do
        it 'returns the travel formatted as "# hour, # minutes"' do
          travel_time_seconds = 6062

          actual = directions.estimated_travel_time(travel_time_seconds)
          expected = '1 hour, 41 minutes'
          expect(actual).to eq(expected)
        end
      end

      context 'when I provide a time in seconds that is 2 or more hours' do
        it 'returns the travel formatted as "# hours, # minutes"' do
          travel_time_seconds = 9662

          actual = directions.estimated_travel_time(travel_time_seconds)
          expected = '2 hours, 41 minutes'
          expect(actual).to eq(expected)
        end
      end

      context 'when I provide time as a float' do
        it 'raises an error' do
          travel_time_seconds = 9662.5

          expect do
            directions.estimated_travel_time(travel_time_seconds)
          end.to raise_error(Directions::TimeMustBeIntegerError)

          expect do
            directions.estimated_travel_time(travel_time_seconds)
          end.to raise_error('Time must be provided as an integer')
        end
      end

      context 'when I provide time as a string' do
        it 'raises an error' do
          travel_time_seconds = '100'

          expect do
            directions.estimated_travel_time(travel_time_seconds)
          end.to raise_error(Directions::TimeMustBeIntegerError)

          expect do
            directions.estimated_travel_time(travel_time_seconds)
          end.to raise_error('Time must be provided as an integer')
        end
      end
    end

    describe '#calculated_travel_time' do
      # See spec/support/directions_response_body.rb for #directions_response_body
      let(:directions) { Directions.new(directions_response_body) }

      context 'when I provide a time in seconds that is less than 1 hour' do
        it 'returns the travel formatted as "# minutes"' do
          travel_time_seconds = 2462

          actual = directions.calculated_travel_time(travel_time_seconds)
          expected = '41 minutes'
          expect(actual).to eq(expected)
        end
      end

      context 'when I provide a time in seconds that is less than 2 hours' do
        it 'returns the travel formatted as "# hour, # minutes"' do
          travel_time_seconds = 6062

          actual = directions.calculated_travel_time(travel_time_seconds)
          expected = '1 hour, 41 minutes'
          expect(actual).to eq(expected)
        end
      end

      context 'when I provide a time in seconds that is 2 or more hours' do
        it 'returns the travel formatted as "# hours, # minutes"' do
          travel_time_seconds = 9662

          actual = directions.calculated_travel_time(travel_time_seconds)
          expected = '2 hours, 41 minutes'
          expect(actual).to eq(expected)
        end
      end

      context 'when I provide time as a float' do
        it 'raises an error' do
          travel_time_seconds = 9662.5

          expect do
            directions.calculated_travel_time(travel_time_seconds)
          end.to raise_error(Directions::TimeMustBeIntegerError)

          expect do
            directions.calculated_travel_time(travel_time_seconds)
          end.to raise_error('Time must be provided as an integer')
        end
      end

      context 'when I provide time as a string' do
        it 'raises an error' do
          travel_time_seconds = '100'

          expect do
            directions.calculated_travel_time(travel_time_seconds)
          end.to raise_error(Directions::TimeMustBeIntegerError)

          expect do
            directions.calculated_travel_time(travel_time_seconds)
          end.to raise_error('Time must be provided as an integer')
        end
      end
    end
  end
end
