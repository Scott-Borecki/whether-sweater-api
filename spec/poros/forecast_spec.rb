require 'rails_helper'

describe Forecast, type: :poro do
  describe 'object creation' do
    # See spec/support/forecast_response_body.rb for test setup helper method:
    #   #forecast_imperial_response_body
    subject(:forecast) { Forecast.new(forecast_imperial_response_body) }

    it 'is valid and has readable attributes', :aggregate_failures do
      expect(forecast).to be_a(Forecast)
      expect(forecast.id).to be_nil

      expect(forecast.current_weather).to be_a(Hash)
      expect(forecast.current_weather.size).to eq(10)

      expect(forecast.current_weather).to have_key(:datetime)
      expect(forecast.current_weather[:datetime]).to be_a(String)

      expect(forecast.current_weather).to have_key(:sunrise)
      expect(forecast.current_weather[:sunrise]).to be_a(String)

      expect(forecast.current_weather).to have_key(:sunset)
      expect(forecast.current_weather[:sunset]).to be_a(String)

      expect(forecast.current_weather).to have_key(:temperature)
      expect(forecast.current_weather[:temperature]).to be_a(Float)

      expect(forecast.current_weather).to have_key(:feels_like)
      expect(forecast.current_weather[:feels_like]).to be_a(Float)

      expect(forecast.current_weather).to have_key(:humidity)
      expect(forecast.current_weather[:humidity]).to be_a(Numeric)

      expect(forecast.current_weather).to have_key(:uvi)
      expect(forecast.current_weather[:uvi]).to be_a(Numeric)

      expect(forecast.current_weather).to have_key(:visibility)
      expect(forecast.current_weather[:visibility]).to be_a(Numeric)

      expect(forecast.current_weather).to have_key(:conditions)
      expect(forecast.current_weather[:conditions]).to be_a(String)

      expect(forecast.current_weather).to have_key(:icon)
      expect(forecast.current_weather[:icon]).to be_a(String)

      expect(forecast.daily_weather).to be_an(Array)
      expect(forecast.daily_weather.first).to be_a(Hash)
      expect(forecast.daily_weather.first.size).to eq(7)

      expect(forecast.daily_weather.first).to have_key(:date)
      expect(forecast.daily_weather.first[:date]).to be_a(String)

      expect(forecast.daily_weather.first).to have_key(:sunrise)
      expect(forecast.daily_weather.first[:sunrise]).to be_a(String)

      expect(forecast.daily_weather.first).to have_key(:sunset)
      expect(forecast.daily_weather.first[:sunset]).to be_a(String)

      expect(forecast.daily_weather.first).to have_key(:max_temp)
      expect(forecast.daily_weather.first[:max_temp]).to be_a(Float)

      expect(forecast.daily_weather.first).to have_key(:min_temp)
      expect(forecast.daily_weather.first[:min_temp]).to be_a(Float)

      expect(forecast.daily_weather.first).to have_key(:conditions)
      expect(forecast.daily_weather.first[:conditions]).to be_a(String)

      expect(forecast.daily_weather.first).to have_key(:icon)
      expect(forecast.daily_weather.first[:icon]).to be_a(String)

      expect(forecast.hourly_weather).to be_an(Array)
      expect(forecast.hourly_weather.first).to be_a(Hash)
      expect(forecast.hourly_weather.first.size).to eq(4)

      expect(forecast.hourly_weather.first).to have_key(:time)
      expect(forecast.hourly_weather.first[:time]).to be_a(String)

      expect(forecast.hourly_weather.first).to have_key(:temperature)
      expect(forecast.hourly_weather.first[:temperature]).to be_a(Float)

      expect(forecast.hourly_weather.first).to have_key(:conditions)
      expect(forecast.hourly_weather.first[:conditions]).to be_a(String)

      expect(forecast.hourly_weather.first).to have_key(:icon)
      expect(forecast.hourly_weather.first[:icon]).to be_a(String)
    end
  end

  describe 'instance methods' do
    describe '#weather_at_eta' do
      # See spec/support/forecast_response_body.rb for test setup helper method:
      #   #forecast_imperial_response_body
      subject(:forecast) { Forecast.new(forecast_imperial_response_body) }

      it 'returns the hourly weather forecast for a given time' do
        travel_time_seconds = 9662

        expected = {
          conditions: 'clear sky',
          temperature: 58.35
        }
        expect(forecast.weather_at_eta(travel_time_seconds)).to eq(expected)
      end
    end
  end
end
