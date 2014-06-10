Rails.application.routes.draw do
  root 'currencies#index'

  resources :trips

  resources :countries, only: [:index]

  resources :currencies, only: [:index, :show]

  resources :visited_countries do
      member do
        get 'visit'
        get 'unvisit'
      end
    end

  devise_for :users
end
