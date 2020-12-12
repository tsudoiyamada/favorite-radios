Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post '/', to: 'radios#create'
  get '/radios', to: 'toppages#index'
  get 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  
  resources :users, only: [:index, :show, :new, :edit, :create, :update] do
    member do
      get :likes
    end 
  end 
    
  resources :radios, only: [:create, :destroy, :show, :new, :edit, :update]
  
  resources :favorites, only: [:create, :destroy]
end 
