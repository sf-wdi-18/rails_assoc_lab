Rails.application.routes.draw do

  root 'welcome#index'

  get '/signup', to: 'users#new', as: 'signup'

  get '/login', to: 'sessions#new', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  post '/sessions', to: 'sessions#create'

  resources :users

end
