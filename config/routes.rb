Rails.application.routes.draw do

  devise_for :users, skip: [:passwords],  controllers: {
   registrations: "user/registrations",
   sessions: 'user/sessions' 
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
   
  devise_scope :user do
    post 'user/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

  scope module: :user do
    root to: "homes#top"
    get 'about' =>"homes#about"
    get "search" => "searches#search"
    get 'followings/followers'
    
    resources :users, only: [:show,:edit,:update,:index] do
      member do
        get :followings, :followers
      end
     resource :relationships, only: [:create,:destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end

    resources :musics, only: [:new,:create, :index, :show, :edit ,:update, :destroy ] do
    resource :favorites, only: [:create,:destroy]
    resources :music_comments,only: [:create,:destroy]
    end

    resources :chats, only: [:show,:create]
  end

  namespace :admin do
     root to: "homes#top"
    resources :musics, only: [:index,:show,:destroy,] do
    resources :music_comments, only: [:destroy]
    end

    resources :music_genres, only:[:index,:create,:edit,:update,:destroy]
    resources :users, only:[:index,:show,:edit,:update,:destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end