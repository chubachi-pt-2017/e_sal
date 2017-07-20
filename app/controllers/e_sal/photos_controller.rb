class ESal::PhotosController < ApplicationController

  def create
    if photo_params
      params[:images].each do |image|
        Photo.create(image: image)
      end
    end
  end

  private
    def photo_params
      params.permit(:id, :images)
    end
end
