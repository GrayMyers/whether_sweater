class Api::V1::UsersController < ApplicationController
  def create
    body = json_body

    user = User.new(email: body[:email], password: body[:password], password_confirmation: body[:password_confirmation])
    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      render json: UsersSerializer.new(user, {params: {api_token: token}}), status: 201
    else
      render json:{errors: user.errors.full_messages.uniq}, status: 400
    end
  end
end
