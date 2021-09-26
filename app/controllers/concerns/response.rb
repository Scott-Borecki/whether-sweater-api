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
        errors: {
          status: error_status,
          title: error_title,
          detail: object
        }
      },
      status: status
    }
  end

  private

  def error_title
    Rack::Utils::HTTP_STATUS_CODES[error_status]
  end

  def error_status
    Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
  end
end
