Rails.application.routes.draw do
# 顧客用
# URL /customers/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
# 管理者用
# URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/' => 'homes#top'
    get '/users' => 'users#index'
    get '/users/:id' => 'users#show', as: 'show'
    get '/users/:id/edit' => 'users#edit', as: 'edit'
    patch '/users/:id' => 'users#update'
    resources :comments, only: [:index, :show, :destroy]
    resources :posts, only: [:index, :show, :edit, :update]
    resources :bushous
  end


  scope module: :public do
    root to: 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'
    get '/users/my_page' => 'users#show'
    get '/users/information/edit' => 'users#edit'
    patch '/users/information' => 'users#update'
    get '/users/betray' => 'users#betray'
    patch '/users/betrayed' => 'users#betrayed'
    get '/users/unsubscribed' => 'users#unsubscribed'
    patch '/users/withdraw' => 'users#withdraw'
    resources :busyous, only: [:index, :show]
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    resources :posts
  end

  #devise_for :users
  #devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
