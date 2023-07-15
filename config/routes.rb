Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
    passwords: 'public/passwords'
  }
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  
# 管理者用
# URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/' => 'homes#top'
    resources :users
    resources :bushous
    resources :comments, only: [:index, :show, :destroy]
    resources :posts, only: [:index, :show, :destroy]
  end


  scope module: :public do
    root to: 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'
    get '/users/information/edit' => 'users#edit'
    patch '/users/information' => 'users#update'
    get '/users/betray' => 'users#betray'
    patch '/users/betrayed' => 'users#betrayed'
    get '/users/unsubscribed' => 'users#unsubscribed'
    patch '/users/withdraw' => 'users#withdraw'
    
    #ゲストログイン追加
    # post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    
    resources :users do
      member do
        get :favorites
      end
    end

    resources :bushous, only: [:index, :show]
    resources :posts do
      #postsコントローラーのsearchアクションにルーティングされる
      get :search, on: :collection
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end

  #devise_for :users
  #devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
