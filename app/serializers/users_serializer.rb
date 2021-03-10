class UsersSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email

  attribute :api_key do |user, params|
    params[:api_token]
  end
end
