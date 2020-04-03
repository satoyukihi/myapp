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
        get :followings, :followers
      end
    end
    resources :microposts,          only: [:new, :show, :edit, :update, :create, :destroy] do
      resources :comments,          only: [:create, :destroy]
    end
    resources :favorite_relationships, only: [:create, :destroy]
    resources :follow_relationships, only: [:create, :destroy]
    resources :notifications, only: :index
    

 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end

