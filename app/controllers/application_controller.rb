class ApplicationController < ActionController::API
  rescue_from JSON::ParserError, with: :return_404

  def return_404
    render json: {error: "bad request"}, status: 404
  end
end
