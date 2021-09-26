class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    return render(invalid_email_or_password) if user.nil?

    if user.authenticate(params[:password])
      render jsonapi: user, status: :ok
    else
      render invalid_email_or_password
    end
  end

  private

  def invalid_email_or_password
    json_error_response(['You have entered an invalid email or password'],
                        :forbidden)
  end
end
