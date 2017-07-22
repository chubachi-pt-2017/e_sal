class ESal::PhotosController < ApplicationController

  def create
    if photo_params
      photos = []
      params[:images].each_with_index do |image, i|
        photos[i] = Photo.create(image: image, user_id: params[:user_id])
      end
      render json: { photos: photos }, :status => 200
    end
  end

  private
    def photo_params
      params.permit(:id, :images, :user_id)
    end
end
