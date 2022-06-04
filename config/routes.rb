Rails.application.routes.draw do
  devise_for :users

  # Defines the root path route ("/")
  root "homepage#home"

  # Api endponits
  namespace :api , defaults: { format: :json } do
    namespace :v1 do
      post 'users/sign_up' => 'users#register'
      post 'users/sign_in' => 'users#login'
    end
  end   

end
