class Api::V1::BackgroundsController < ApplicationController
  before_action :check_location

  def get_bg_image
    coords = GeocodeFacade.get_position(params[:location]) # comment for testing if CI works

    image_info = ImageFacade.get_image(coords)

    render json: ImageSerializer.new(image_info)
  end
end
