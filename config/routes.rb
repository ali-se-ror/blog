Rails.application.routes.draw do
  resources :list_users
  resources :replies
  resources :comments
  resources :lists
  resources :cards
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
  put '/user/reset_password', to: 'users#reset_password'
end