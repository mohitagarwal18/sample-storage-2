Rails.application.routes.draw do
  
  devise_for :users

  devise_scope :user do
    
    get    '/login',   to: "devise/sessions#new"
    post    '/login',   to: "devise/sessions#create"
    get 'signup', to: "devise/registrations#new"
    delete '/logout', to: "devise/sessions#destroy"
  end
  
  
  # post   '/login',   to: 'sessions#create'
  # delete '/logout',  to: 'sessions#destroy'
  root to: "dashboard#index"
  
  get '/dashboard' , to: 'dashboard#index'
  
  resources :users, only: [:new, :create, :edit, :update]
  resources :artifacts,          only: [:create, :destroy]
  get '/search', to: 'dashboard#index'
  get '/sort', to: 'dashboard#sort'
  get '/download', to: 'artifacts#download'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
