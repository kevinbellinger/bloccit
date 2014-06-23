Rails.application.routes.draw do

  root to: "welcome#index"

  get 'about' => "welcome#about"

  
  resources :topics do
    resources :posts, except: [:index] do
      resources :comments, only: [:create]
    end
  end

  devise_for :users
  resources :users, only: [:update]



end

  