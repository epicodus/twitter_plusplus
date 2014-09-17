Rails.application.routes.draw do

  devise_for :users
  resource :tweets

  root to: 'application#index'
  get '/timeline', to: 'tweets#index', as: :user_root
  get '/timeline/follow/:id', to: 'tweets#follow', as: :timeline_follow_user
  get '/timeline/unfollow/:id', to: 'tweets#unfollow', as: :timeline_unfollow_user

  get '/tweets/search', to:'tweets#search', as: :tweets_search
  get '/users/search', to:'users#search', as: :users_search
  get '/user/:id', to: 'users#show', as: :user_show
end
