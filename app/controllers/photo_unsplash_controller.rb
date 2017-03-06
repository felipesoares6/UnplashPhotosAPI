class PhotoUnsplashController < ApplicationController
  def search
    @photos = PhotoUnsplashService.search(query_params)
    render json: @photos
  end

  def top_five
    @photos = PhotoUnsplashService.top_five(query_params)
    render json: @photos
  end

  private
  def query_params
    { query: params[:query], page: params[:page], per_page: params[:per_page] }
  end
end
