Rails.application.routes.draw do
  devise_for :users

  # Defines the root path route ("/")
  root "homepage#home"

  # Api endponits
  namespace :api , defaults: { format: :json } do
    namespace :v1 do
      post 'users/sign_up' => 'users#register'
      post 'users/sign_in' => 'users#login'
      get 'posts/load' => 'posts#index'
      post 'posts/create' => 'posts#create'
      delete 'posts/delete' => 'posts#destroy'
      get 'comments/load' => 'comments#index'
      post 'comments/create' => 'comments#create'
      delete 'comments/delete' => 'comments#destroy'
    end
  end   

end
