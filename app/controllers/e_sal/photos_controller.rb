class ESal::PhotosController < ApplicationController

  def create
    if photo_params
      params[:images].each do |image|
        Photo.create(image: image, user_id: params[:user_id])
      end
    end
  end

  private
    def photo_params
      params.permit(:id, :images, :user_id)
    end
end
