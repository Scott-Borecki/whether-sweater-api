require 'rails_helper'

describe ForecastFacade, type: :facade do
  describe 'class methods' do
    describe '.get_forecast', :vcr do
      context 'when I provide a valid location' do
        subject(:forecast) { ForecastFacade.get_forecast(location) }

        let(:location) { 'denver,co' }

        it 'returns a Forecast object' do
          expect(forecast).to be_an_instance_of(Forecast)
        end
      end

      context 'when I do not provide a valid location' do
        subject(:error_serializer) { ForecastFacade.get_forecast(empty_location) }

        let(:empty_location) { '' }

        it 'returns an ErrorSerializer object' do
          expect(error_serializer).to be_an_instance_of(ErrorSerializer)
          expect(error_serializer.status).to be_an(Integer)
          expect(error_serializer.messages).to be_an(Array)
        end
      end
    end
  end
end
