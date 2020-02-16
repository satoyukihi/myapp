Rails.application.routes.draw do
  get 'sessions/new'

    root 'static_pages#home'
    get  '/signup',    to: 'users#new'
    post '/signup',    to: 'users#create'
    get    '/login',   to: 'sessions#new'
    post   '/login',   to: 'sessions#create'
    delete '/logout',  to: 'sessions#destroy'
    
    resources :users do
      member do
        get :likes
      end
    end
  
    resources :microposts,          only: [:new, :show, :create, :destroy]
    resources :favorite_relationships, only: [:create, :destroy]
    

 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end

