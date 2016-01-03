Rails.application.routes.draw do
  root to: 'home#index'

  resources :tweet_searches
  resources :tweet_analysis
  resources :tweets
  
end
