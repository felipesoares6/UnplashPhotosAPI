class PhotoUnsplashController < ApplicationController
  def top_five
    @photos = PhotoUnsplashService.top_five(query_params)

    if params[:query].present?
      render json: @photos
    else
      render json: {}, status: 422
    end
  end

  private
  def query_params
    { query: params[:query], page: params[:page], per_page: params[:per_page] }
  end
end
