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
          status: Rack::Utils::SYMBOL_TO_STATUS_CODE[status],
          title: status.to_s.tr('_', ' ').titleize,
          detail: object
        }
      },
      status: status
    }
  end
end
