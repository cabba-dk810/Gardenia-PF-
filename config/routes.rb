Rails.application.routes.draw do
  devise_for :admins


  # ユーザ用ルーティング
  devise_for :users

  resources :users, only: [:show, :edit, :update]
  get 'users/:id/exit' => 'users#exit', as: 'exit'
  get 'users/:id/follower' => 'users#follower', as: 'follower'
  get 'users/:id/following' => 'users#following', as: 'following'

  resources :post_gardens, only: [:new, :create, :show, :edit, :update, :destroy]
  root to: 'post_gardens#index'
  get 'post_gardens/about' => 'post_gardens#about', as: 'about'
  get 'post_gardens/:id/new_open_garden' => 'post_gardens#new_open_garden', as: 'new_open_garden'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
