# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  mount Sidekiq::Web => '/sidekiq'

  get '/api_key', to: 'api_key#show'
  get '/api_key/edit', to: 'api_key#edit'
  post '/api_key', to: 'api_key#update'

  resources :albums do
    resources :channels
    resources :videos, only: %i[index new]
  end

  devise_scope :user do
    get 'login', to: 'api_key#show'
    get 'logout' => 'devise/sessions#destroy'
  end

  root 'albums#index'
end
