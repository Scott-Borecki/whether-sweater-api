require 'rails_helper'

describe QuantityValidator, type: :validator do
  describe 'object creation' do
    describe 'valid objects' do
      context 'when I provide a valid quantity' do
        it 'creates a valid object' do
          quantity = { quantity: 5 }
          validator = QuantityValidator.new(quantity)

          expect(validator).to be_valid
        end
      end
    end

    describe 'invalid objects' do
      context 'when I do not provide a quantity' do
        it 'does not create a valid object' do
          validator = QuantityValidator.new

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq({ quantity: ["can't be blank", 'is not a number'] })
        end
      end

      context 'when I provide an empty quantity' do
        it 'does not create a valid object' do
          quantity = { quantity: '' }
          validator = QuantityValidator.new(quantity)

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq({ quantity: ["can't be blank", 'is not a number'] })
        end
      end

      context 'when I provide a negative quantity' do
        it 'does not create a valid object' do
          quantity = { quantity: -5 }
          validator = QuantityValidator.new(quantity)

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq({ quantity: ['must be greater than 0'] })
        end
      end

      context 'when I provide a quantity of zero' do
        it 'does not create a valid object' do
          quantity = { quantity: 0 }
          validator = QuantityValidator.new(quantity)

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq({ quantity: ['must be greater than 0'] })
        end
      end

      context 'when I provide a quantity as a float' do
        it 'does not create a valid object' do
          quantity = { quantity: 5.5 }
          validator = QuantityValidator.new(quantity)

          expect(validator).not_to be_valid
          expect(validator.errors.messages).to eq({ quantity: ['must be an integer'] })
        end
      end
    end
  end
end
