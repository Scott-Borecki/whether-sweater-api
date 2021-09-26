require 'rails_helper'

describe LocationValidator, type: :validator do
  describe 'object creation' do
    describe 'valid objects' do
      context 'when I provide a location' do
        it 'creates a valid object' do
          location = { location: 'denver,co' }
          validator = LocationValidator.new(location)

          expect(validator).to be_valid
        end
      end
    end

    describe 'invalid objects' do
      context 'when I do not provide a location' do
        it 'does not create a valid object' do
          location = { location: '' }
          validator = LocationValidator.new(location)

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq({ location: ["can't be blank"] })
        end
      end

      context 'when I do not provide any parameters' do
        it 'does not create a valid object' do
          validator = LocationValidator.new

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq({ location: ["can't be blank"] })
        end
      end
    end
  end
end
