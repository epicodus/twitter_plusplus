Rails.application.routes.draw do

  devise_for :users
  root to: 'application#index'

  # get 'profile', to: 'users#show'
  # get 'login', to: user_session_path
  # get 'logout', to: destroy_user_session_path
end
