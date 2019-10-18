Rails.application.routes.draw do
  resources :matches
  resources :messages
  resources :chats
  resources :pets
  resources :preferences
  resources :users
  post '/login', to: 'authentication#login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
