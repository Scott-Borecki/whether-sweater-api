module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    # Raised by ActiveRecord::Base#save! and ActiveRecord::Base#create! when
    #   the record is invalid.
    rescue_from ActiveRecord::RecordInvalid do |e|
      render json_response(
        {
          errors:
            e.record.errors.full_messages.map do |message|
              {
                status: '422',
                title: 'Unprocessable Entity',
                detail: "Your record could not be saved: #{message}"
              }
            end
        },
        :unprocessable_entity
      )
    end
  end
end
