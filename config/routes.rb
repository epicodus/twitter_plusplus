Rails.application.routes.draw do

  devise_for :users
  #resources :users, only: [:index, :show]
  resource :tweets

  root to: 'application#index'
  get '/timeline', to: 'tweets#index', as: :user_root
  get '/follow/:id', to: 'users#follow', as: :follow_user
  get '/unfollow/:id', to: 'users#unfollow', as: :unfollow_user
  get '/search', to:'tweets#search'
end
