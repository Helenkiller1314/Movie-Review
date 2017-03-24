Rails.application.routes.draw do
  devise_for :users
  root 'movies#index'
  resources :movies do
    member do
      post :favorite
      post :unfavorite
    end
    resources :reviews
  end

  namespace :account do
    resources :movies
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
