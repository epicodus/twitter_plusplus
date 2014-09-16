Rails.application.routes.draw do

  devise_for :users
  #resources :users, only: [:index, :show]
  resource :tweets

  root to: 'application#index'
  get 'timeline', to: 'tweets#index', as: :user_root
  get 'follow/:id', to: 'relations#follow', as: :follow_user
end
