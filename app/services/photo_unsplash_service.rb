class PhotoUnsplashService
  def self.search (query, page: 1, per_page: 5)
    Unsplash::Photo.search(query, page, per_page)
  end

  def self.top_five (query)
    @photos = self.search(query, per_page: 30)

    @photos.sort! { |a, b| b.likes <=> a.likes }

    @photos.first(5)
  end
end
