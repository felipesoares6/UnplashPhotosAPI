class PhotoUnsplashController < ApplicationController
  def search
    @photos = PhotoUnsplashService.search(query, page, per_page)
    render json: @photos
  end

  def top_five
    @photos = PhotoUnsplashService.top_five(query)
    render json: @photos
  end

  def query
    params[:query]
  end

  def page
    params[:page] || 1
  end

  def per_page
    params[:per_page] || 5
  end
end
