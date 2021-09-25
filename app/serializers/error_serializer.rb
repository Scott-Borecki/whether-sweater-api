class ErrorSerializer
  attr_reader :status, :messages

  def initialize(arguments)
    @status   = arguments[:status]
    @messages = arguments[:messages]
  end

  def to_hash
    {
      errors:
        messages.map do |message|
          {
            status: status.to_s,
            detail: message
          }
        end
    }
  end
end
