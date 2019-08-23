Rails.application.routes.draw do
  
  get    '/login',   to: 'sessions#new'
  get    '/signup',   to: 'users#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  root 'sessions#new'
  get '/dashboard' , to: 'dashboard#index'
  resources :users, only: [:new, :create, :edit, :update]
  resources :artifacts,          only: [:create, :destroy]
  get '/search', to: 'dashboard#index'
  get '/sort', to: 'dashboard#sort'
  get '/download', to: 'artifacts#download'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
