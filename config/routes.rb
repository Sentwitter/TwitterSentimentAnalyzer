Rails.application.routes.draw do
  root to: 'home#index'

  post '/set_http_proxy', to: 'home#set_http_proxy'
  resources :tweet_searches

end
