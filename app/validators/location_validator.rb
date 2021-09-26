class LocationValidator
  include ActiveModel::Validations

  attr_accessor :location

  validates :location, presence: true

  def initialize(data = {})
    @location = data[:location]
  end
end
