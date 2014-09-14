Rails.application.routes.draw do

  devise_for :users
  # resources :users, only: :show

  root to: 'application#index'

  #todo remap user_root_path to redirect devise after login
  
end
