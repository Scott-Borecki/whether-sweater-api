require 'rails_helper'

describe ForecastService, type: :service do
  describe 'class methods' do
    describe '.get_forecast' do
      context 'when I provide valid coordinates', :vcr do
        subject(:forecast) { ForecastService.get_forecast(coordinates) }

        let(:coordinates) { { lat: 39.738453, lon: -104.984853 } }

        it 'returns the forecast as a hash', :aggregate_failures do
          expect(forecast).to be_a(Hash)

          expect(forecast).to have_key(:lat)
          expect(forecast[:lat]).to eq(coordinates[:lat].round(4))

          expect(forecast).to have_key(:lon)
          expect(forecast[:lon]).to eq(coordinates[:lon].round(4))

          expect(forecast).to have_key(:current)
          expect(forecast[:current]).to be_a(Hash)

          expect(forecast[:current]).to have_key(:dt)
          expect(forecast[:current][:dt]).to be_an(Integer)

          expect(forecast[:current]).to have_key(:sunrise)
          expect(forecast[:current][:sunrise]).to be_an(Integer)

          expect(forecast[:current]).to have_key(:sunrise)
          expect(forecast[:current][:sunrise]).to be_an(Integer)

          expect(forecast[:current]).to have_key(:temp)
          expect(forecast[:current][:temp]).to be_a(Float)

          expect(forecast[:current]).to have_key(:feels_like)
          expect(forecast[:current][:feels_like]).to be_a(Float)

          expect(forecast[:current]).to have_key(:humidity)
          expect(forecast[:current][:humidity]).to be_an(Integer)

          expect(forecast[:current]).to have_key(:uvi)
          if forecast[:current][:uvi].zero?
            expect(forecast[:current][:uvi]).to be_an(Integer)
          else
            expect(forecast[:current][:uvi]).to be_a(Float)
          end

          expect(forecast[:current]).to have_key(:visibility)
          expect(forecast[:current][:visibility]).to be_an(Integer)

          expect(forecast[:current]).to have_key(:weather)
          expect(forecast[:current][:weather]).to be_an(Array)
          expect(forecast[:current][:weather].first).to be_a(Hash)

          expect(forecast[:current][:weather].first).to have_key(:description)
          expect(forecast[:current][:weather].first[:description]).to be_a(String)

          expect(forecast[:current][:weather].first).to have_key(:icon)
          expect(forecast[:current][:weather].first[:icon]).to be_a(String)

          expect(forecast).to have_key(:daily)
          expect(forecast[:daily]).to be_an(Array)
          expect(forecast[:daily].first).to be_a(Hash)

          expect(forecast[:daily].first).to have_key(:dt)
          expect(forecast[:daily].first[:dt]).to be_an(Integer)

          expect(forecast[:daily].first).to have_key(:sunrise)
          expect(forecast[:daily].first[:sunrise]).to be_an(Integer)

          expect(forecast[:daily].first).to have_key(:sunrise)
          expect(forecast[:daily].first[:sunrise]).to be_an(Integer)

          expect(forecast[:daily].first).to have_key(:temp)
          expect(forecast[:daily].first[:temp]).to be_a(Hash)

          expect(forecast[:daily].first[:temp]).to have_key(:max)
          expect(forecast[:daily].first[:temp][:max]).to be_a(Float)

          expect(forecast[:daily].first[:temp]).to have_key(:min)
          expect(forecast[:daily].first[:temp][:min]).to be_a(Float)

          expect(forecast[:daily].first[:weather].first).to have_key(:description)
          expect(forecast[:daily].first[:weather].first[:description]).to be_a(String)

          expect(forecast[:daily].first[:weather].first).to have_key(:icon)
          expect(forecast[:daily].first[:weather].first[:icon]).to be_a(String)

          expect(forecast).to have_key(:hourly)
          expect(forecast[:hourly]).to be_an(Array)
          expect(forecast[:hourly].first).to be_a(Hash)

          expect(forecast[:hourly].first).to have_key(:dt)
          expect(forecast[:hourly].first[:dt]).to be_an(Integer)

          expect(forecast[:hourly].first).to have_key(:temp)
          expect(forecast[:hourly].first[:temp]).to be_a(Float)

          expect(forecast[:hourly].first[:weather].first).to have_key(:description)
          expect(forecast[:hourly].first[:weather].first[:description]).to be_a(String)

          expect(forecast[:hourly].first[:weather].first).to have_key(:icon)
          expect(forecast[:hourly].first[:weather].first[:icon]).to be_a(String)
        end
      end

      context 'when I do not provide coordinates', :vcr do
        subject(:response) { ForecastService.get_forecast(empty_coordinates) }

        let(:empty_coordinates) { { lat: '', lon: '' } }

        it 'returns the error details as a hash', :aggregate_failures do
          expect(response).to be_a(Hash)
          expect(response[:cod]).to eq('400')
          expect(response[:message]).to eq('Nothing to geocode')
        end
      end
    end
  end
end
