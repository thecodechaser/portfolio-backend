Rails.application.routes.draw do
  devise_for :users

  # Defines the root path route ("/")
  root "homepage#home"

  # Api endponits
  namespace :api , defaults: { format: :json } do
    namespace :v1 do
      post 'users/sign_up' => 'users#register'
      post 'users/sign_in' => 'users#login'
      post 'users/load' => 'users#index'
      get 'posts/load' => 'posts#index'
      post 'posts/create' => 'posts#create'
      delete 'posts/delete' => 'posts#destroy'
      post 'comments/load' => 'comments#index'
      post 'comments/create' => 'comments#create'
      delete 'comments/delete' => 'comments#destroy'
      post 'replies/load' => 'replies#index'
      post 'replies/create' => 'replies#create'
      delete 'replies/delete' => 'replies#destroy'
      post 'likes/load' => 'likes#index'
      post 'likes/create' => 'likes#create'
      delete 'likes/delete' => 'likes#destroy'
    end
  end   

end
