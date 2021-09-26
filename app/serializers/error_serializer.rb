class ErrorSerializer
  attr_reader :status, :messages

  def initialize(arguments)
    @status   = arguments[:status].to_i
    @messages = arguments[:messages]
  end

  def to_hash
    {
      errors:
        messages.map do |message|
          if title.present?
            {
              status: status.to_s,
              title: title,
              detail: message
            }
          else
            {
              status: status.to_s,
              detail: message
            }
          end
        end
    }
  end

  def title
    Rack::Utils::HTTP_STATUS_CODES[status]
  end
end
