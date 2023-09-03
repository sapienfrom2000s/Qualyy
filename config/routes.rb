Rails.application.routes.draw do
  get 'channels/index'

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/api_key', to: 'api_key#show'
  get '/api_key/edit', to: 'api_key#edit'
  post '/api_key', to: 'api_key#update'

  resources :channels

  devise_scope :user do
    get 'login', to: 'api_key#show'
    get 'logout' => 'devise/sessions#destroy'
  end

  root 'channels#index'
end
