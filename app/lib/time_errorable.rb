module TimeErrorable
  class DataTypeError < StandardError; end

  class TimeMustBeIntegerError < DataTypeError
    def message
      'Time must be provided as an integer'
    end
  end
end
