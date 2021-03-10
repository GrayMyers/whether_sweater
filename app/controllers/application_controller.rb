class ApplicationController < ActionController::API
  rescue_from JSON::ParserError, with: :return_404

  private

  def validate_token(token)
    decoded_hash = JsonWebToken.decode(token)
    id = decoded_hash[:user_id].to_i
    id if id != 0
  end

  def json_body
    JSON.parse(request.body.read, symbolize_headers: true).symbolize_keys
  end

  def return_404
    render json: {error: "bad request"}, status: 404
  end

  def check_location
    if !params[:location] || params[:location] == ""
      render json: {error: "invalid location"}, status: 404
    end
  end
end
