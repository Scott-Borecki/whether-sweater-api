class QuantityValidator
  include ActiveModel::Validations

  attr_accessor :quantity

  validates :quantity, presence: true,
                       numericality: { only_integer: true, greater_than: 0 }

  def initialize(data = {})
    @quantity = data[:quantity]
  end
end
