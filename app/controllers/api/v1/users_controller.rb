class Api::V1::UsersController < ApplicationController
  def create
    body = JSON.parse(request.body.read, symbolize_headers: true).symbolize_keys

    user = User.new(email: body[:email], password: body[:password], password_confirmation: body[:password_confirmation])
    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      render json: UserSerializer.new(user, {params: {api_token: token}})
    else
      render json:{errors: user.errors.full_messages.uniq}, status: 400
    end
  end
end