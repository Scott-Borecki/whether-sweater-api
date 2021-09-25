require 'rails_helper'

describe Location, type: :poro do
  describe 'object creation' do
    it 'is valid and has readable attributes' do
      # See spec/support/location_response_body.rb for #location_response_body
      data     = location_response_body
      location = Location.new(data)

      expect(location).to be_a(Location)
      expect(location.latitude).to eq(39.738453)
      expect(location.longitude).to eq(-104.984853)
    end
  end
end
