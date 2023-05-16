Rails.application.routes.draw do
  resources :events

  get 'static_pages/index'
  get 'static_pages/secret'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'events#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
