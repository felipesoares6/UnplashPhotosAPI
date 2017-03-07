Rails.application.routes.draw do
  get '/top_five', to: 'photo_unsplash#top_five'
end
