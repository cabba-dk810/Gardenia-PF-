Rails.application.routes.draw do
  devise_for :admins


  # ユーザ用ルーティング
  devise_for :users

  resources :users, only: [:show, :edit, :update] do
    get 'users/following', to: 'users#following', on: :member
    get 'users/follower', to: 'users#follower', on: :member
  end
  get 'users/:id/exit' => 'users#exit', as: 'exit'
  get 'users/:id/follower' => 'users#follower', as: 'follower'
  get 'users/:id/following' => 'users#following', as: 'following'

  resources :post_gardens, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :post_comments, only: [:create, :destroy]
    post 'likes', to: 'likes#create', on: :member
    delete 'likes', to: 'likes#destroy', on: :member
  end
  root to: 'post_gardens#index'
  get 'about' => 'post_gardens#about', as: 'about'
  get 'post_gardens/:id/new_open_garden' => 'post_gardens#new_open_garden', as: 'new_open_garden'
  get 'search_result' => 'post_gardens#search_result', as: 'search_result'
  patch 'post_gardens/:id/delete_open_info' => 'post_gardens#delete_open_info', as: 'delete_open_info'

  resources :likes, only: [:index]

  resources :post_images, only: [:destroy]

  resources :open_days, only: [:create, :update, :destroy]
  # resources :new_open_garden

  resources :relationships, only: [:create]
  delete 'relationships/:id' => 'relationships#destroy', as: 'unfollow'

  resources :reservations, only: [:create, :show, :edit, :update]
  get 'reservations/new/:id' => 'reservations#new', as: 'new_reservation'
  get 'done' => 'reservations#done', as: 'done'
  get 'accept_reservations/:id' => 'reservations#accept_reservations', as: 'accept_reservations'
  get 'request_reservations/:id' => 'reservations#request_reservations', as: 'request_reservations'
  get 'approve_reservation/:id' => 'reservations#approve_reservation', as: 'approve_reservation'
  get 'approved/:id' => 'reservations#approved', as: 'approved'
  get 'cancel_reason/:id' => 'reservations#cancel_reason', as: 'cancel_reason'
  get 'canceled/:id' => 'reservations#canceled', as: 'canceled'

  resources :notifications, only: :index

end
