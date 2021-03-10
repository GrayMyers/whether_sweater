class Api::V1::SessionsController < ApplicationController
  def create
    body = json_body

    user = User.find_by(email: body[:email])
    if user.authenticate(body[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: UsersSerializer.new(user, {params: {api_token: token}})
    else
      render json: {error: "bad credentials"}, status: 401
    end
  end
end
