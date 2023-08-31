Rails.application.routes.draw do

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/api_key', to: 'api_key#show'
  get '/api_key/edit', to: 'api_key#edit'

  devise_scope :user do
    get 'login', to: 'api_key#show'
    get 'logout' => 'devise/sessions#destroy'
  end

  root 'api_key#show'
end
