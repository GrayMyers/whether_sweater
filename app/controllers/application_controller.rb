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
    render_error(["bad request"], 404)
  end

  def render_error(errors,status)
    render json: {errors: errors}, status: status
  end

  def check_location
    if !params[:location] || params[:location] == ""
      render_error(["invalid location"], 404)
    end
  end
end
