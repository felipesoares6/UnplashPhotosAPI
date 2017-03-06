Rails.application.routes.draw do
  get '/random', to: 'photo_unsplash#search'
  get '/top_five', to: 'photo_unsplash#top_five'
end
