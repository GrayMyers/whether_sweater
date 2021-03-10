class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email

  attribute :api_token do |user, params|
    params[:api_token]
  end
end
