Rails.application.routes.draw do
  #トップページ
  root to: "toppages#index"
  
  #ログイン
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  #ユーザー
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create, :destroy] do
    member do
      get :favorites
      get :drafts
    end
  end
  
  #小説
  resources :novels, only: [:new, :show, :create, :update, :edit, :destroy]
  
  #お気に入り機能
  resources :favorites, only: [:create, :destroy]
end
