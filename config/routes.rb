Rails.application.routes.draw do
  devise_for :admins


  # ユーザ用ルーティング
  devise_for :users

  resources :users, only: [:show, :edit, :update]
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
  get 'post_gardens/search_result' => 'post_gardens#search_result', as: 'search_result'
  patch 'post_gardens/:id/delete_open_info' => 'post_gardens#delete_open_info', as: 'delete_open_info'

  resources :open_days, only: [:create, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
