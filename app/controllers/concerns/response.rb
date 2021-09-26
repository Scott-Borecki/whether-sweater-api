module Response
  def json_response(object, status = :ok)
    {
      json: object,
      status: status
    }
  end

  def json_error_response(object, status = :bad_request)
    {
      json: {
        errors:
          if object.is_a? Array
            object.map do |detail|
              {
                status: error_status(status).to_s,
                title: error_title(status),
                detail: detail
              }
            end
          else
            object.map do |key, value|
              {
                status: error_status(status).to_s,
                title: error_title(status),
                detail: "#{key.to_s.titleize} #{value}"
              }
            end
          end
      },
      status: status
    }
  end

  private

  def error_title(status)
    Rack::Utils::HTTP_STATUS_CODES[error_status(status)]
  end

  def error_status(status)
    Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
  end
end
