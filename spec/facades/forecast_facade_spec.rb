require 'rails_helper'

describe ForecastFacade, type: :facade do
  describe 'class methods' do
    describe '.get_forecast', :vcr do
      context 'when I provide valid coordinates' do
        subject(:forecast) { ForecastFacade.get_forecast(coordinates) }

        let(:coordinates) { { lat: 39.738453, lon: -104.984853 } }

        it 'returns a Location object' do
          expect(forecast).to be_an_instance_of(Forecast)
        end
      end

      context 'when I do not provide coordinates' do
        subject(:error_serializer) { ForecastFacade.get_forecast(empty_coordinates) }

        let(:empty_coordinates) { { lat: '', lon: '' } }

        it 'returns an ErrorSerializer object' do
          expect(error_serializer).to be_an_instance_of(ErrorSerializer)
          expect(error_serializer.status).to be_an(Integer)
          expect(error_serializer.messages).to be_an(Array)
        end
      end
    end
  end
end
