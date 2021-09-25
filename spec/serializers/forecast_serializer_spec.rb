require 'rails_helper'

describe ForecastSerializer, type: :serializer do
  describe 'object creation' do
    subject(:forecast_serializer) { ForecastSerializer.new(forecast) }

    # See spec/support/forecast_response_body.rb for test setup helper method:
    #   #forecast_imperial_response_body
    let(:forecast) { Forecast.new(forecast_imperial_response_body) }

    it 'is valid and has readable attributes', :aggregate_failures do
      expect(forecast_serializer).to be_a(ForecastSerializer)
    end
  end

  describe 'instance methods' do
    describe '#serializable_hash' do
      subject(:forecast_hash) { ForecastSerializer.new(forecast).serializable_hash }

      # See spec/support/forecast_response_body.rb for test setup helper method:
      #   #forecast_imperial_response_body
      let(:forecast) { Forecast.new(forecast_imperial_response_body) }

      it 'returns a JSON:API compliable hash', :aggregate_failures do
        expect(forecast_hash).to be_a(Hash)

        expect(forecast_hash).to have_key(:data)
        expect(forecast_hash[:data]).to be_a(Hash)
        expect(forecast_hash[:data].size).to eq(3)

        expect(forecast_hash[:data]).to have_key(:id)
        expect(forecast_hash[:data][:id]).to be_nil

        expect(forecast_hash[:data]).to have_key(:type)
        expect(forecast_hash[:data][:type]).to eq(:forecast)

        expect(forecast_hash[:data]).to have_key(:attributes)
        expect(forecast_hash[:data][:attributes]).to be_a(Hash)
        expect(forecast_hash[:data][:attributes].size).to eq(3)
      end
    end
  end
end
