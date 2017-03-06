class PhotoUnsplashService

  def self.search (params)
    self.check_params(params)
    Unsplash::Photo.search(params[:query], params[:page], params[:per_page])
  end

  def self.top_five (params)
    params[:per_page] = 30

    @photos = self.search(params)

    @photos.sort! { |a, b| b.likes <=> a.likes }

    @photos.first(5)
  end

  def self.check_params (params)
    params[:query] ||= ''
    params[:page] ||= 1
    params[:per_page] ||= 5
  end
end
